import os
import parseopt2

import "plist.nim"

proc strValue(plist: plist_t): cstring =
  var str_value: cstring
  plist.plist_get_string_val(addr str_value)
  return str_value

template getKeyStringValue(plist: plist_t, key: cstring): cstring =
  if plist.plist_dict_get_item(key) == nil: nil
  else: plist.plist_dict_get_item(key).strValue()
  
iterator dictItems(plist: plist_t): tuple[key: cstring, value: plist_t] {.inline.} = 
  var plist_iter: plist_dict_iter
  plist.plist_dict_new_iter(addr plist_iter)
  var key: cstring
  var value: plist_t
  plist.plist_dict_next_item(plist_iter, addr key, addr value)
  while (key != nil and value != nil):
    yield (key, value)
    plist.plist_dict_next_item(plist_iter, addr key, addr value)

iterator arrayItems(plist: plist_t): plist_t {.inline.} =
  for index in 0..plist.plist_array_get_size():
    yield plist.plist_array_get_item(index)

# ===========
# Entry Point
# ===========

let bookmarks_plist_path = expandTilde("~/Library/Safari/bookmarks.plist")

if bookmarks_plist_path.fileExists():
  let bookmarks = open(bookmarks_plist_path)
  let size = bookmarks.getFileSize()
  let data = alloc(size)
  discard bookmarks.readBuffer(data, size)
  bookmarks.close()

  var plist: plist_t
  plist_from_bin(data, uint32(size), addr plist)

  var saved_items: plist_t
  
  let elements = plist.plist_dict_get_item("Children")
  if elements != nil:
    for element in elements.arrayItems():
      if element.getKeyStringValue("Title") == "com.apple.ReadingList":
        saved_items = element
        break

  if saved_items != nil:
    let reading_list_elements = saved_items.plist_dict_get_item("Children")
    for reading_list_item in reading_list_elements.arrayItems():
      let urlstring = reading_list_item.getKeyStringValue("URLString")
      if urlstring != nil:
        echo(urlstring)
