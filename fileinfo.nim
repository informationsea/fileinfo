import os
import json
import times
import parseopt
import system

type
  MyFileInfo = object
    path: string
    device_id: os.DeviceId
    file_id: os.FileId
    permission: string
    file_type: string
    size: system.BiggestInt
    last_modification_date: string
    last_access_date: string
    creation_date: string
    link_count: system.BiggestInt


var p = initOptParser()
var output = ""
var file_list: seq[string]

while true:
  p.next()
  case p.kind
       of cmdEnd: break
       of cmdShortOption, cmdLongOption:
         case p.key
              of "o": output = p.val
              else:
                echo "Unknown option:", p.key
       of cmdArgument:
         file_list.add(p.key)

var file_seq: seq[MyFileInfo] = @[]
let date_format = "yyyy-MM-dd HH:mm:sszzz"

var all_last_modification_date = times.Time()
var all_last_access_date = times.Time()
var all_last_creation_date = times.Time()

for one_file in file_list:
  let fileinfo = os.getFileInfo(one_file, true)
  all_last_modification_date = max(all_last_modification_date, fileinfo.lastWriteTime)
  all_last_access_date = max(all_last_access_date, fileinfo.lastAccessTime)
  all_last_creation_date = max(all_last_creation_date, fileinfo.creationTime)
  
  var file_type: string
  case fileinfo.kind
       of pcFile: file_type = "file"
       of pcLinkToFile: file_type = "file-link"
       of pcDir: file_type = "directory"
       of pcLinkToDir: file_type = "directory-link"

  file_seq.add(
    MyFileInfo(
      path: os.normalizedPath(os.absolutePath(one_file)),
      file_type: file_type,
      device_id: fileinfo.id[0],
      file_id: fileinfo.id[1],
      size: fileinfo.size,
      last_modification_date: fileinfo.lastWriteTime.format(date_format),
      last_access_date: fileinfo.lastAccessTime.format(date_format),
      creation_date: fileinfo.creationTime.format(date_format),
      link_count: fileinfo.linkCount
    )
  )

let fileinfo_json = %* {
  "filelist": file_seq,
  "last_modification_date": all_last_modification_date.format(date_format),
  "last_access_date": all_last_access_date.format(date_format),
  "last_creation_date": all_last_creation_date.format(date_format)
}

if output == "":
  echo pretty(fileinfo_json, indent = 4)
else:
  writeFile(output, pretty(fileinfo_json, indent = 4))
