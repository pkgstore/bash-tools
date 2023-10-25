#!/usr/bin/bash -e
#
# Generating 'favicon' file.
#
# @package    Bash
# @author     Kitsune Solar <mail@kitsune.solar>
# @copyright  2023 iHub TO
# @license    MIT
# @version    0.0.1
# @link       https://lib.onl
# -------------------------------------------------------------------------------------------------------------------- #

size=( 16 24 32 48 64 72 80 96 128 144 152 167 180 192 196 256 300 512 )
file_svg='favicon.svg'
file_ico='favicon.ico'

rsvg="$( command -v rsvg-convert )"
convert="$( command -v convert )"
identify="$( command -v identify )"

png() {
  _check_file
  for i in "${size[@]}"; do
    ${rsvg} -w "${i}" -h "${i}" "${file_svg}" -o "favicon-${i}.png"
  done
}

ico() {
  _check_file
  ${convert} -density '256x256' -background 'transparent' "${file_svg}" -define 'icon:auto-resize' -colors '256' "${file_ico}"
  ${identify} "${file_ico}"
}

_check_file() {
  [[ -f "${file_svg}" ]] || { printf '%s does not exist!\n' "${file_svg}"; exit 1; }
}

"$@"
