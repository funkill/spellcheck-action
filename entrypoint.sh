#!/bin/sh

set -euo pipefail

repo_dir=

dict_filename=${GITHUB_WORKSPACE}/${INPUT_DICTIONARY}
sources=${GITHUB_WORKSPACE}/${INPUT_SOURCES}
files_pattern=${INPUT_FILES_PATTERN}
lang=${INPUT_LANG}


if [ ! -f $dict_filename ]; then
  echo "personal_ws-1.1 $lang 0 utf-8" > "$dict_filename"
fi
# aspell repeatedly modifies the personal dictionary for some reason,
# so we should use a copy of our dictionary.
find $sources -type f -name $files_pattern | xargs aspell --lang $lang --ignore 3 --dont-backup --personal="$dict_filename" check

#
