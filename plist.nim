## *
##  @file plist/plist.h
##  @brief Main include of libplist
##  \internal
## 
##  Copyright (c) 2008 Jonathan Beck All Rights Reserved.
## 
##  This library is free software; you can redistribute it and/or
##  modify it under the terms of the GNU Lesser General Public
##  License as published by the Free Software Foundation; either
##  version 2.1 of the License, or (at your option) any later version.
## 
##  This library is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
##  Lesser General Public License for more details.
## 
##  You should have received a copy of the GNU Lesser General Public
##  License along with this library; if not, write to the Free Software
##  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
## 

## *
##  \mainpage libplist : A library to handle Apple Property Lists
##  \defgroup PublicAPI Public libplist API
## 
## @{
## *
##  The basic plist abstract data type.
## 

type
  plist_t* = pointer

## *
##  The plist dictionary iterator.
## 

type
  plist_dict_iter* = pointer

## *
##  The enumeration of plist node types.
## 

type
  plist_type* {.size: sizeof(cint).} = enum
    PLIST_BOOLEAN,            ## *< Boolean, scalar type
    PLIST_UINT,               ## *< Unsigned integer, scalar type
    PLIST_REAL,               ## *< Real, scalar type
    PLIST_STRING,             ## *< ASCII string, scalar type
    PLIST_ARRAY,              ## *< Ordered array, structured type
    PLIST_DICT,               ## *< Unordered dictionary (key/value pair), structured type
    PLIST_DATE,               ## *< Date, scalar type
    PLIST_DATA,               ## *< Binary data, scalar type
    PLIST_KEY,                ## *< Key in dictionaries (ASCII String), scalar type
    PLIST_UID,                ## *< Special type used for 'keyed encoding'
    PLIST_NONE                ## *< No type


## *******************************************
##                                           *
##           Creation & Destruction          *
##                                           *
## ******************************************
## *
##  Create a new root plist_t type #PLIST_DICT
## 
##  @return the created plist
##  @sa #plist_type
## 

proc plist_new_dict*(): plist_t {.importc: "plist_new_dict", header: "/usr/local/include/plist/plist.h".}
## *
##  Create a new root plist_t type #PLIST_ARRAY
## 
##  @return the created plist
##  @sa #plist_type
## 

proc plist_new_array*(): plist_t {.importc: "plist_new_array", header: "/usr/local/include/plist/plist.h".}
## *
##  Create a new plist_t type #PLIST_STRING
## 
##  @param val the sting value, encoded in UTF8.
##  @return the created item
##  @sa #plist_type
## 

proc plist_new_string*(val: cstring): plist_t {.importc: "plist_new_string", header: "/usr/local/include/plist/plist.h".}
## *
##  Create a new plist_t type #PLIST_BOOLEAN
## 
##  @param val the boolean value, 0 is false, other values are true.
##  @return the created item
##  @sa #plist_type
## 

proc plist_new_bool*(val: uint8): plist_t {.importc: "plist_new_bool", header: "/usr/local/include/plist/plist.h".}
## *
##  Create a new plist_t type #PLIST_UINT
## 
##  @param val the unsigned integer value
##  @return the created item
##  @sa #plist_type
## 

proc plist_new_uint*(val: uint64): plist_t {.importc: "plist_new_uint", header: "/usr/local/include/plist/plist.h".}
## *
##  Create a new plist_t type #PLIST_REAL
## 
##  @param val the real value
##  @return the created item
##  @sa #plist_type
## 

proc plist_new_real*(val: cdouble): plist_t {.importc: "plist_new_real", header: "/usr/local/include/plist/plist.h".}
## *
##  Create a new plist_t type #PLIST_DATA
## 
##  @param val the binary buffer
##  @param length the length of the buffer
##  @return the created item
##  @sa #plist_type
## 

proc plist_new_data*(val: cstring, length: uint64): plist_t {.importc: "plist_new_data", header: "/usr/local/include/plist/plist.h".}
## *
##  Create a new plist_t type #PLIST_DATE
## 
##  @param sec the number of seconds since 01/01/2001
##  @param usec the number of microseconds
##  @return the created item
##  @sa #plist_type
## 

proc plist_new_date*(sec: int32, usec: int32): plist_t {.importc: "plist_new_date", header: "/usr/local/include/plist/plist.h".}
## *
##  Create a new plist_t type #PLIST_UID
## 
##  @param val the unsigned integer value
##  @return the created item
##  @sa #plist_type
## 

proc plist_new_uid*(val: uint64): plist_t {.importc: "plist_new_uid", header: "/usr/local/include/plist/plist.h".}
## *
##  Destruct a plist_t node and all its children recursively
## 
##  @param plist the plist to free
## 

proc plist_free*(plist: plist_t) {.importc: "plist_free", header: "/usr/local/include/plist/plist.h".}
## *
##  Return a copy of passed node and it's children
## 
##  @param node the plist to copy
##  @return copied plist
## 

proc plist_copy*(node: plist_t): plist_t {.importc: "plist_copy", header: "/usr/local/include/plist/plist.h".}
## *******************************************
##                                           *
##             Array functions               *
##                                           *
## ******************************************
## *
##  Get size of a #PLIST_ARRAY node.
## 
##  @param node the node of type #PLIST_ARRAY
##  @return size of the #PLIST_ARRAY node
## 

proc plist_array_get_size*(node: plist_t): uint32 {.importc: "plist_array_get_size", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the nth item in a #PLIST_ARRAY node.
## 
##  @param node the node of type #PLIST_ARRAY
##  @param n the index of the item to get. Range is [0, array_size[
##  @return the nth item or NULL if node is not of type #PLIST_ARRAY
## 

proc plist_array_get_item*(node: plist_t; n: uint32): plist_t {.importc: "plist_array_get_item", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the index of an item. item must be a member of a #PLIST_ARRAY node.
## 
##  @param node the node
##  @return the node index
## 

proc plist_array_get_item_index*(node: plist_t): uint32 {.importc: "plist_array_get_item_index", header: "/usr/local/include/plist/plist.h".}
## *
##  Set the nth item in a #PLIST_ARRAY node.
##  The previous item at index n will be freed using #plist_free
## 
##  @param node the node of type #PLIST_ARRAY
##  @param item the new item at index n. The array is responsible for freeing item when it is no longer needed.
##  @param n the index of the item to get. Range is [0, array_size[. Assert if n is not in range.
## 

proc plist_array_set_item*(node: plist_t, item: plist_t, n: uint32) {.importc: "plist_array_set_item", header: "/usr/local/include/plist/plist.h".}
## *
##  Append a new item at the end of a #PLIST_ARRAY node.
## 
##  @param node the node of type #PLIST_ARRAY
##  @param item the new item. The array is responsible for freeing item when it is no longer needed.
## 

proc plist_array_append_item*(node: plist_t, item: plist_t) {.importc: "plist_array_append_item", header: "/usr/local/include/plist/plist.h".}
## *
##  Insert a new item at position n in a #PLIST_ARRAY node.
## 
##  @param node the node of type #PLIST_ARRAY
##  @param item the new item to insert. The array is responsible for freeing item when it is no longer needed.
##  @param n The position at which the node will be stored. Range is [0, array_size[. Assert if n is not in range.
## 

proc plist_array_insert_item*(node: plist_t, item: plist_t; n: uint32) {.importc: "plist_array_insert_item", header: "/usr/local/include/plist/plist.h".}
## *
##  Remove an existing position in a #PLIST_ARRAY node.
##  Removed position will be freed using #plist_free.
## 
##  @param node the node of type #PLIST_ARRAY
##  @param n The position to remove. Range is [0, array_size[. Assert if n is not in range.
## 

proc plist_array_remove_item*(node: plist_t, n: uint32) {.importc: "plist_array_remove_item", header: "/usr/local/include/plist/plist.h".}
## *******************************************
##                                           *
##          Dictionary functions             *
##                                           *
## ******************************************
## *
##  Get size of a #PLIST_DICT node.
## 
##  @param node the node of type #PLIST_DICT
##  @return size of the #PLIST_DICT node
## 

proc plist_dict_get_size*(node: plist_t): uint32 {.importc: "plist_dict_get_size", header: "/usr/local/include/plist/plist.h".}
## *
##  Create an iterator of a #PLIST_DICT node.
##  The allocated iterator should be freed with the standard free function.
## 
##  @param node the node of type #PLIST_DICT
##  @param iter iterator of the #PLIST_DICT node
## 

proc plist_dict_new_iter*(node: plist_t, iter: ptr plist_dict_iter) {.importc: "plist_dict_new_iter", header: "/usr/local/include/plist/plist.h".}
## *
##  Increment iterator of a #PLIST_DICT node.
## 
##  @param node the node of type #PLIST_DICT
##  @param iter iterator of the dictionary
##  @param key a location to store the key, or NULL. The caller is responsible
## 		for freeing the the returned string.
##  @param val a location to store the value, or NULL. The caller should *not*
## 		free the returned value.
## 

proc plist_dict_next_item*(node: plist_t, iter: plist_dict_iter, key: ptr cstring, val: ptr plist_t) {.importc: "plist_dict_next_item", header: "/usr/local/include/plist/plist.h".}
## *
##  Get key associated to an item. Item must be member of a dictionary
## 
##  @param node the node
##  @param key a location to store the key. The caller is responsible for freeing the returned string.
## 

proc plist_dict_get_item_key*(node: plist_t, key: ptr cstring) {.importc: "plist_dict_get_item_key", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the nth item in a #PLIST_DICT node.
## 
##  @param node the node of type #PLIST_DICT
##  @param key the identifier of the item to get.
##  @return the item or NULL if node is not of type #PLIST_DICT. The caller should not free
## 		the returned node.
## 

proc plist_dict_get_item*(node: plist_t, key: cstring): plist_t {.importc: "plist_dict_get_item", header: "/usr/local/include/plist/plist.h".}
## *
##  Set item identified by key in a #PLIST_DICT node.
##  The previous item identified by key will be freed using #plist_free.
##  If there is no item for the given key a new item will be inserted.
## 
##  @param node the node of type #PLIST_DICT
##  @param item the new item associated to key
##  @param key the identifier of the item to set.
## 

proc plist_dict_set_item*(node: plist_t, key: cstring, item: plist_t) {.importc: "plist_dict_set_item", header: "/usr/local/include/plist/plist.h".}
## *
##  Remove an existing position in a #PLIST_DICT node.
##  Removed position will be freed using #plist_free
## 
##  @param node the node of type #PLIST_DICT
##  @param key The identifier of the item to remove. Assert if identifier is not present.
## 

proc plist_dict_remove_item*(node: plist_t, key: cstring) {.importc: "plist_dict_remove_item", header: "/usr/local/include/plist/plist.h".}
## *
##  Merge a dictionary into another. This will add all key/value pairs
##  from the source dictionary to the target dictionary, overwriting
##  any existing key/value pairs that are already present in target.
## 
##  @param target pointer to an existing node of type #PLIST_DICT
##  @param source node of type #PLIST_DICT that should be merged into target
## 

proc plist_dict_merge*(target: ptr plist_t, source: plist_t) {.importc: "plist_dict_merge", header: "/usr/local/include/plist/plist.h".}
## *******************************************
##                                           *
##                 Getters                   *
##                                           *
## ******************************************
## *
##  Get the parent of a node
## 
##  @param node the parent (NULL if node is root)
## 

proc plist_get_parent*(node: plist_t): plist_t {.importc: "plist_get_parent", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the #plist_type of a node.
## 
##  @param node the node
##  @return the type of the node
## 

proc plist_get_node_type*(node: plist_t): plist_type {.importc: "plist_get_node_type", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the value of a #PLIST_KEY node.
##  This function does nothing if node is not of type #PLIST_KEY
## 
##  @param node the node
##  @param val a pointer to a C-string. This function allocates the memory,
##             caller is responsible for freeing it.
## 

proc plist_get_key_val*(node: plist_t, val: ptr cstring) {.importc: "plist_get_key_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the value of a #PLIST_STRING node.
##  This function does nothing if node is not of type #PLIST_STRING
## 
##  @param node the node
##  @param val a pointer to a C-string. This function allocates the memory,
##             caller is responsible for freeing it. Data is UTF-8 encoded.
## 

proc plist_get_string_val*(node: plist_t, val: ptr cstring) {.importc: "plist_get_string_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the value of a #PLIST_BOOLEAN node.
##  This function does nothing if node is not of type #PLIST_BOOLEAN
## 
##  @param node the node
##  @param val a pointer to a uint8_t variable.
## 

proc plist_get_bool_val*(node: plist_t, val: ptr uint8) {.importc: "plist_get_bool_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the value of a #PLIST_UINT node.
##  This function does nothing if node is not of type #PLIST_UINT
## 
##  @param node the node
##  @param val a pointer to a uint64_t variable.
## 

proc plist_get_uint_val*(node: plist_t, val: ptr uint64) {.importc: "plist_get_uint_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the value of a #PLIST_REAL node.
##  This function does nothing if node is not of type #PLIST_REAL
## 
##  @param node the node
##  @param val a pointer to a double variable.
## 

proc plist_get_real_val*(node: plist_t, val: ptr cdouble) {.importc: "plist_get_real_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the value of a #PLIST_DATA node.
##  This function does nothing if node is not of type #PLIST_DATA
## 
##  @param node the node
##  @param val a pointer to an unallocated char buffer. This function allocates the memory,
##             caller is responsible for freeing it.
##  @param length the length of the buffer
## 

proc plist_get_data_val*(node: plist_t, val: ptr cstring, length: ptr uint64) {.importc: "plist_get_data_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the value of a #PLIST_DATE node.
##  This function does nothing if node is not of type #PLIST_DATE
## 
##  @param node the node
##  @param sec a pointer to an int32_t variable. Represents the number of seconds since 01/01/2001.
##  @param usec a pointer to an int32_t variable. Represents the number of microseconds
## 

proc plist_get_date_val*(node: plist_t, sec: ptr int32, usec: ptr int32) {.importc: "plist_get_date_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Get the value of a #PLIST_UID node.
##  This function does nothing if node is not of type #PLIST_UID
## 
##  @param node the node
##  @param val a pointer to a uint64_t variable.
## 

proc plist_get_uid_val*(node: plist_t, val: ptr uint64) {.importc: "plist_get_uid_val", header: "/usr/local/include/plist/plist.h".}
## *******************************************
##                                           *
##                 Setters                   *
##                                           *
## ******************************************
## *
##  Set the value of a node.
##  Forces type of node to #PLIST_KEY
## 
##  @param node the node
##  @param val the key value
## 

proc plist_set_key_val*(node: plist_t, val: cstring) {.importc: "plist_set_key_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Set the value of a node.
##  Forces type of node to #PLIST_STRING
## 
##  @param node the node
##  @param val the string value. The string is copied when set and will be
## 		freed by the node.
## 

proc plist_set_string_val*(node: plist_t, val: cstring) {.importc: "plist_set_string_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Set the value of a node.
##  Forces type of node to #PLIST_BOOLEAN
## 
##  @param node the node
##  @param val the boolean value
## 

proc plist_set_bool_val*(node: plist_t, val: uint8) {.importc: "plist_set_bool_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Set the value of a node.
##  Forces type of node to #PLIST_UINT
## 
##  @param node the node
##  @param val the unsigned integer value
## 

proc plist_set_uint_val*(node: plist_t, val: uint64) {.importc: "plist_set_uint_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Set the value of a node.
##  Forces type of node to #PLIST_REAL
## 
##  @param node the node
##  @param val the real value
## 

proc plist_set_real_val*(node: plist_t, val: cdouble) {.importc: "plist_set_real_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Set the value of a node.
##  Forces type of node to #PLIST_DATA
## 
##  @param node the node
##  @param val the binary buffer. The buffer is copied when set and will
## 		be freed by the node.
##  @param length the length of the buffer
## 

proc plist_set_data_val*(node: plist_t, val: cstring, length: uint64) {.importc: "plist_set_data_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Set the value of a node.
##  Forces type of node to #PLIST_DATE
## 
##  @param node the node
##  @param sec the number of seconds since 01/01/2001
##  @param usec the number of microseconds
## 

proc plist_set_date_val*(node: plist_t, sec: int32, usec: int32) {.importc: "plist_set_date_val", header: "/usr/local/include/plist/plist.h".}
## *
##  Set the value of a node.
##  Forces type of node to #PLIST_UID
## 
##  @param node the node
##  @param val the unsigned integer value
## 

proc plist_set_uid_val*(node: plist_t, val: uint64) {.importc: "plist_set_uid_val", header: "/usr/local/include/plist/plist.h".}
## *******************************************
##                                           *
##             Import & Export               *
##                                           *
## ******************************************
## *
##  Export the #plist_t structure to XML format.
## 
##  @param plist the root node to export
##  @param plist_xml a pointer to a C-string. This function allocates the memory,
##             caller is responsible for freeing it. Data is UTF-8 encoded.
##  @param length a pointer to an uint32_t variable. Represents the length of the allocated buffer.
## 

proc plist_to_xml*(plist: plist_t, plist_xml: pointer, length: ptr uint32) {.importc: "plist_to_xml", header: "/usr/local/include/plist/plist.h".}
## *
##  Export the #plist_t structure to binary format.
## 
##  @param plist the root node to export
##  @param plist_bin a pointer to a char* buffer. This function allocates the memory,
##             caller is responsible for freeing it.
##  @param length a pointer to an uint32_t variable. Represents the length of the allocated buffer.
## 

proc plist_to_bin*(plist: plist_t, plist_bin: pointer, length: ptr uint32) {.importc: "plist_to_bin", header: "/usr/local/include/plist/plist.h".}
## *
##  Import the #plist_t structure from XML format.
## 
##  @param plist_xml a pointer to the xml buffer.
##  @param length length of the buffer to read.
##  @param plist a pointer to the imported plist.
## 

proc plist_from_xml*(plist_xml: pointer, length: uint32, plist: ptr plist_t) {.importc: "plist_from_xml", header: "/usr/local/include/plist/plist.h".}
## *
##  Import the #plist_t structure from binary format.
## 
##  @param plist_bin a pointer to the xml buffer.
##  @param length length of the buffer to read.
##  @param plist a pointer to the imported plist.
## 

proc plist_from_bin*(plist_bin: pointer, length: uint32, plist: ptr plist_t) {.importc: "plist_from_bin", header: "/usr/local/include/plist/plist.h".}
## *******************************************
##                                           *
##                  Utils                    *
##                                           *
## ******************************************
## *
##  Get a node from its path. Each path element depends on the associated father node type.
##  For Dictionaries, var args are casted to const char*, for arrays, var args are caster to uint32_t
##  Search is breath first order.
## 
##  @param plist the node to access result from.
##  @param length length of the path to access
##  @return the value to access.
## 

proc plist_access_path*(plist: plist_t, length: uint32): plist_t {.varargs, importc: "plist_access_path", header: "/usr/local/include/plist/plist.h".}
## *
##  Variadic version of #plist_access_path.
## 
##  @param plist the node to access result from.
##  @param length length of the path to access
##  @param v list of array's index and dic'st key
##  @return the value to access.
## 

proc plist_access_pathv*(plist: plist_t, length: uint32; v: varargs): plist_t {.importc: "plist_access_pathv", header: "/usr/local/include/plist/plist.h".}
## *
##  Compare two node values
## 
##  @param node_l left node to compare
##  @param node_r rigth node to compare
##  @return TRUE is type and value match, FALSE otherwise.
## 

proc plist_compare_node_value*(node_l: plist_t, node_r: plist_t): char {.importc: "plist_compare_node_value", header: "/usr/local/include/plist/plist.h".}
## @}
