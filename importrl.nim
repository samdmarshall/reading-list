import os
import plists
import parseopt2


for kind, key, value in getopt():
  case kind
  of cmdLongOption:
    case key:
    of "dump":
      discard
    else:
      discard
  else:
    discard

let data: JsonNode = loadPlist(expandTilde("~/Library/Safari/bookmarks.plist"))
echo(data)
