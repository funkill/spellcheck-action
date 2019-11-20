#!/bin/sh

set -euo pipefail

dict_filename="${GITHUB_WORKSPACE}/${INPUT_DICTIONARY}"
sources="${INPUT_SOURCES}"
files_pattern="${INPUT_FILES_PATTERN}"
lang="${INPUT_LANG}"
only_changed="${INPUT_ONLY_CHANGED}"

if [ ! -f $dict_filename ]; then
  echo "personal_ws-1.1 ${lang} 0 utf-8" > "${dict_filename}"
fi

if [ "${only_changed}" = "true" ]; then
  files=$(git show -m --name-only -1 --format="format:" | grep --color=never -i "$files_pattern")
else
  files=$(find "${GITHUB_WORKSPACE}/${sources}" -type f -name "${files_pattern}")
fi

failed=0
for file in ${files}; do
  words=$(aspell --lang $lang --ignore 3 --dont-backup --personal="${dict_filename}" list < "${file}")
  if [ "$words" != "" ]; then
    failed=1
    echo "${file}:"
    for word in $words; do
      grep -on "${word}" "${file}"
    done
  fi
done

exit $failed

#
