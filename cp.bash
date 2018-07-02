#!/bin/bash

set -e

if [ $# -lt 1 ] ; then
    echo "$0: ERROR: expected some arguments"
    echo "Usage: $0 <files>"
    exit 1
fi

echo "$0: Copying following files to ./src..."
for file in "$@" ; do
    echo "    - $file"
done

cp "$@" ./src/

for file in "$@" ; do
  base="$(basename "$file")"
  ./convert.bash "./src/${base}"
done
