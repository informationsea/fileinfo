fileinfo
========
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/informationsea/fileinfo)](https://hub.docker.com/r/informationsea/fileinfo)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/informationsea/fileinfo)](https://hub.docker.com/r/informationsea/fileinfo)

Print file size, modification time and other attributes as JSON

Usage
-----

```
$ fileinfo -o:output.json README.md LICENSE
```

Output example
--------------

```json
{
    "filelist": [
        {
            "path": "/home/okamura/Documents/Programming/nim/fileinfo/README.md",
            "device_id": 2096,
            "file_id": 49352,
            "permission": "",
            "file_type": "file",
            "size": 1340,
            "last_modification_date": "2020-06-29 23:36:23+09:00",
            "last_access_date": "2020-06-29 23:35:56+09:00",
            "creation_date": "2020-06-29 23:36:23+09:00",
            "link_count": 1
        },
        {
            "path": "/home/okamura/Documents/Programming/nim/fileinfo/LICENSE",
            "device_id": 2096,
            "file_id": 49399,
            "permission": "",
            "file_type": "file",
            "size": 1055,
            "last_modification_date": "2020-06-29 23:35:47+09:00",
            "last_access_date": "2020-06-29 23:35:47+09:00",
            "creation_date": "2020-06-29 23:35:47+09:00",
            "link_count": 1
        }
    ],
    "last_modification_date": "2020-06-29 23:36:23+09:00",
    "last_access_date": "2020-06-29 23:35:56+09:00",
    "last_creation_date": "2020-06-29 23:36:23+09:00"
}
```
