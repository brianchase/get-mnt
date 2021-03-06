#!/bin/bash

# From: https://github.com/brianchase/get-mnt
# See also: https://github.com/brianchase/mnt-dev

get_new_arrays () {
# See chk_arrays and dev_arrays in mnt-dev.sh.
  chk_arrays || get_error "No mounted device selected!"
  unset DevArr1 DevArr2 MntArr1 MntArr2
  dev_arrays
}

get_menu () {
  while true; do
    local N=0 Opt i
    printf '%s\n\n' "Please choose:"
# List all mounted devices for selection.
    for i in "${!DevArr2[@]}"; do
      printf '\t%s\n' "$((N += 1)). ${DevArr2[i]} mounted on ${MntArr2[i]}"
    done
    printf '\t%s\n' "$((N += 1)). Skip"
    read -r Opt
    case $Opt in
      ''|*[!1-9]*) continue ;;
      "$N") return 1 ;;
    esac
    [ "$Opt" -gt "$N" ] && continue
    break
  done
# Make the selected device DevArr2[0] and its mount point MntArr2[0].
  DevArr2=("${DevArr2[@]:(($Opt - 1)):1}")
  MntArr2=("${MntArr2[@]:(($Opt - 1)):1}")
}

get_chk_arrays () {
  while true; do
    if [ "${#DevArr2[*]}" -eq 0 ]; then
# If there's no mounted device, see about mounting one.
      get_new_arrays
      [ "${#DevArr2[*]}" -eq 1 ] && break
      [ "${#DevArr2[*]}" -gt 1 ] && continue
      get_error "No mounted device selected!"
    elif [ "${#DevArr2[*]}" -eq 1 ]; then

# If there's just one mounted device (not selected earlier), ask to
# use it. If you decline, see about mounting another one.

      if [ "${DevArr2[0]}" != "$TempA" ]; then
        local UseDev
        read -r -p "Use ${DevArr2[0]} mounted on ${MntArr2[0]}? [y/n] " UseDev
        [ "$UseDev" = y ] && break
        if [ "${#DevArr1[*]}" -ge 1 ]; then
          local TempA="${DevArr2[0]}"
          get_new_arrays
          [ "${#DevArr2[*]}" -ge 1 ] && continue
        fi
      fi
      get_error "No mounted device selected!"
    elif [ "${#DevArr2[*]}" -gt 1 ]; then
# If there's more than one mounted device, build a menu of options.
      get_menu && break
# If you chose "skip" in get_menu, see about mounting another device.
      get_new_arrays
    fi
  done
}

get_error () {
  printf '%s\n' "$1" >&2
  exit 1
}

get_main () {
# Use dev_arrays in mnt-dev.sh to get DevArr1, DevArr2, MntArr1, and MntArr2.
  [ -x "$(command -v mnt-dev.sh)" ] || get_error "'mnt-dev.sh' not found!"
  source mnt-dev.sh
  dev_arrays
  get_chk_arrays
}

get_main
