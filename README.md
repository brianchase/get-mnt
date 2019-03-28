# get-mnt

## About

This Bash script works with my
[mnt-dev.sh](https://github.com/brianchase/mnt-dev "mnt-dev.sh") to
select a mounted device. It's therefore not a standalone script.
Rather, it augments the functionality of
[mnt-dev.sh](https://github.com/brianchase/mnt-dev "mnt-dev.sh") when
you want to perform an operation on a mounted device, such as
transferring files, but need to indicate which device to use (if more
than one is mounted) or to mount one before using it (if one or more
are connected).

For a practical example of how to use the script, please see my
[archive-rsync.sh](https://github.com/brianchase/archive-rsync
"archive-rsync.sh"), which uses [rsync](https://rsync.samba.org
"rsync") to back up local files to a connected device.

## License

This project is in the public domain under [The
Unlicense](https://choosealicense.com/licenses/unlicense/ "The
Unlicense").

## Requirements

* [mnt-dev.sh](https://github.com/brianchase/mnt-dev "mnt-dev.sh")

