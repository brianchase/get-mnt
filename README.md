# get-mnt

## ABOUT

This Bash script works with
[mnt-dev](https://github.com/brianchase/mnt-dev) to select a mounted
device for use in other operations, such as transferring files. For a
practical example, please see
[archive-rsync](https://github.com/brianchase/mnt-dev), a Bash script
for backing up files.

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

* [mnt-dev](https://github.com/brianchase/mnt-dev)

