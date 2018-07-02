#!/bin/bash

set -e

if [ $# -lt 1 ] ; then
    echo "Usage: $0 <file>"
    echo "Description: This script converts a text file format to UTF-8 (LF)."
    echo "Prerequisites: dos2unix, nkf"
fi

for file in "$@" ; do
    dos2unix "$file"
    nkf -w --overwrite "$file"
done
