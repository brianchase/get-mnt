#!/bin/bash

get_new_arrays () {
  if chk_arrays; then
    unset DevArr1 DevArr2 MntArr1 MntArr2
    dev_arrays
  else
    printf '%s\n' "No mounted device selected!" >&2
    exit 1
  fi
}

get_menu () {
  while true; do
    local N=0 Opt i
    printf '%s\n\n' "Please choose:"
    for i in "${!DevArr2[@]}"; do
      printf '\t%s\n' "$((N += 1)). ${DevArr2[i]} mounted at ${MntArr2[i]}"
    done
    printf '\t%s\n' "$((N += 1)). Exit"
    read -r Opt
    case $Opt in
      ''|*[!1-9]*) continue ;;
    esac
    if [ "$Opt" -gt "$N" ]; then
      continue
    elif [ "$Opt" = "$N" ]; then
      return 1
    fi
    break
  done
  local TempA="${DevArr2[(($Opt - 1))]}"
  local TempB="${MntArr2[(($Opt - 1))]}"
  unset DevArr2 MntArr2
  DevArr2[0]="$TempA"
  MntArr2[0]="$TempB"
}

get_chk_arrays () {
  while true; do
    if [ "${#DevArr2[*]}" -eq 0 ]; then
      get_new_arrays
      if [ "${#DevArr2[*]}" -eq 1 ]; then
        break
      elif [ "${#DevArr2[*]}" -gt 1 ]; then
        continue
      fi
      printf '%s\n' "No mounted device selected!" >&2
      exit 1
    elif [ "${#DevArr2[*]}" -eq 1 ]; then
      if [ "${DevArr2[0]}" != "$TempA" ]; then
        local UseDev
        read -r -p "Use ${DevArr2[0]} mounted at ${MntArr2[0]}? [y/n] " UseDev
        if [ "$UseDev" = y ]; then
          break
        elif [ "${#DevArr1[*]}" -ge 1 ]; then
          local TempA="${DevArr2[0]}"
          get_new_arrays
          if [ "${#DevArr2[*]}" -ge 1 ]; then
            continue
          fi
        fi
      fi
      printf '%s\n' "No mounted device selected!" >&2
      exit 1
    elif [ "${#DevArr2[*]}" -gt 1 ]; then
      if get_menu; then
        break
      else
        get_new_arrays
      fi
    fi
  done
}

get_main () {
  if [ -x "$(command -v mnt-dev.sh)" ]; then
    source mnt-dev.sh
    dev_arrays
    get_chk_arrays
  else
    printf '%s\n' "'mnt-dev.sh' not found!" \
      "Please visit https://github.com/brianchase/mnt-dev" >&2
    exit 1
  fi
}

get_main
