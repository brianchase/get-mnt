#!/bin/bash

get_new_a2 () {
  chk_arrays
  unset A1 A2 B1 B2
  dev_arrays
}

get_menu () {
  while true; do
    local N=0
    printf '%s\n\n' "Please choose:"
    for i in "${!A2[@]}"; do
      printf '\t%s\n' "$((N += 1)). ${A2[$i]} mounted at ${B2[$i]}"
    done
    printf '\t%s\n' "$((N += 1)). Exit"
    local OP
    read -r OP
    case $OP in
      ''|*[!1-9]*) continue ;;
    esac
    if [ "$OP" -gt "$N" ]; then
      continue
    elif [ "$OP" = "$N" ]; then
      return 1
    fi
    break
  done
  local TempA="${A2[(($OP - 1))]}"
  local TempB="${B2[(($OP - 1))]}"
  unset A2 B2
  A2[0]="$TempA"
  B2[0]="$TempB"
}

get_chk_arrays () {
  while true; do
    if [ "${#A2[*]}" -eq 0 ]; then
      get_new_a2
      if [ "${#A2[*]}" -eq 1 ]; then
        break
      elif [ "${#A2[*]}" -gt 1 ]; then
        continue
      fi
      printf '%s\n' "No mounted device selected!"
      exit 1
    elif [ "${#A2[*]}" -eq 1 ]; then
      if [ "${A2[0]}" != "$TempA" ]; then
        read -r -p "Use ${A2[0]} mounted at ${B2[0]}? [y/n] " UD
        if [ "$UD" = y ]; then
          break
        elif [ "$((${#A1[*]} + ${#A2[*]}))" -gt 1 ]; then
          local TempA="${A2[0]}"
          get_new_a2
          if [ "${#A2[*]}" -ge 1 ]; then
            continue
          fi
        fi
      fi
      printf '%s\n' "No mounted device selected!"
      exit 1
    elif [ "${#A2[*]}" -gt 1 ]; then
      get_menu
      break
    fi
  done
}

get_main () {
  if [ -x "$(command -v mnt-dev.sh)" ]; then
    source mnt-dev.sh
    dev_arrays
    get_chk_arrays
  else
    printf '%s\n' "mnt-dev.sh not found!"
    printf '%s\n' "Please visit https://github.com/brianchase/mnt-dev"
    exit 1
  fi
}

get_main
