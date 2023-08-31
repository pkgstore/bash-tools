#!/usr/bin/bash -e
#
# Backup files with timestamp.
#
# @package    Bash
# @author     Kitsune Solar <mail@kitsune.solar>
# @copyright  2023 iHub TO
# @license    MIT
# @version    0.0.1
# @link       https://github.com/pkgstore
# -------------------------------------------------------------------------------------------------------------------- #

(( EUID == 0 )) && { echo >&2 'This script should not be run as root!'; exit 1; }

# -------------------------------------------------------------------------------------------------------------------- #
# CONFIGURATION.
# -------------------------------------------------------------------------------------------------------------------- #

p7zip="$( command -v 7zzs )"
date="$( command -v date )"

# Help.
read -r -d '' help <<- EOF
Options:
  -d 'DIR_1;DIR_2;DIR_3'                Directories (array).
  -s 'SECRET'                           Archive password.
EOF

# -------------------------------------------------------------------------------------------------------------------- #
# OPTIONS.
# -------------------------------------------------------------------------------------------------------------------- #

OPTIND=1

while getopts 'd:s:h' opt; do
  case ${opt} in
    d)
      dirs="${OPTARG}"; IFS=';' read -ra dirs <<< "${dirs}"
      ;;
    s)
      secret="${OPTARG}"
      ;;
    h|*)
      echo "${help}"; exit 2
      ;;
  esac
done

shift $(( OPTIND - 1 ))

(( ! ${#dirs[@]} )) && { echo >&2 '[ERROR] Directories not specified!'; exit 1; }

# -------------------------------------------------------------------------------------------------------------------- #
# INITIALIZATION.
# -------------------------------------------------------------------------------------------------------------------- #

init() {
  backup
}

# -------------------------------------------------------------------------------------------------------------------- #
# BACKUP: FILES.
# -------------------------------------------------------------------------------------------------------------------- #

backup() {
  ts="$( _timestamp )"

  for dir in "${dirs[@]}"; do
    local name="${dir}.${ts}"

    echo '' && echo "--- OPEN: '${dir}'"
    ${p7zip} a -t7z -m0=lzma2 -mx=9 "${name}.7z" -p"${secret}" -mhe "${dir}"
    echo '' && echo "--- DONE: '${dir}'" && echo ''
  done
}

# -------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------< COMMON FUNCTIONS >------------------------------------------------ #
# -------------------------------------------------------------------------------------------------------------------- #

# Timestamp: Date.
_timestamp() {
  ${date} -u '+%Y-%m-%d.%H-%M-%S'
}

# -------------------------------------------------------------------------------------------------------------------- #
# -------------------------------------------------< INIT FUNCTIONS >------------------------------------------------- #
# -------------------------------------------------------------------------------------------------------------------- #

init "$@"; exit 0
