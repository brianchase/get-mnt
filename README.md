# get-mnt

## ABOUT

This Bash script works with my
[mnt-dev.sh](https://github.com/brianchase/mnt-dev) to select a
mounted device. It's therefore not a standalone script. Rather, it
augments the functionality of
[mnt-dev.sh](https://github.com/brianchase/mnt-dev) when you want to
perform an operation on a mounted device, such as transferring files,
but need to indicate which device to use (if more than one is mounted)
or to mount one before using it (if one or more are connected).

For a practical example of how to use the script, please see my
[archive-rsync.sh](https://github.com/brianchase/archive-rsync), which
uses [rsync](https://rsync.samba.org/) to backup local files to a
connected device.

## PORTABILITY

Since the script uses arrays, it's not strictly
[POSIX](https://en.wikipedia.org/wiki/POSIX)-compliant. As a result,
it isn't compatible with
[Dash](http://gondor.apana.org.au/~herbert/dash/) and probably a good
number of other shells.

## LICENSE

This project is in the public domain under [The
Unlicense](https://choosealicense.com/licenses/unlicense/).

## REQUIREMENTS

* [mnt-dev.sh](https://github.com/brianchase/mnt-dev)

