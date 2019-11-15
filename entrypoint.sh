#!/bin/sh

set -euo pipefail

dict_filename=${INPUTS_DICTIONARY}
sources=${INPUTS_SOURCE_DIR}
files_pattern=${INPUTS_FILES_PATTERN}
lang=${INPUTS_LANG}


if [ ! -f $dict_filename ]; then
  echo "personal_ws-1.1 $lang 0 utf-8" > "$dict_filename"
fi
# aspell repeatedly modifies the personal dictionary for some reason,
# so we should use a copy of our dictionary.
find $sources -type f -name $files_pattern | xargs aspell --lang $lang --ignore 3 --dont-backup --personal="$dict_filename" check

#
