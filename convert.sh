#!/bin/sh

if [ $# -lt 1 ] ; then
    echo "Usage: $0 <file>"
    echo "Description: This script converts a text file format to UTF-8 (LF)."
    echo "Prerequisites: dos2unix, nkf"
fi

dos2unix "$1"
nkf -w --overwrite "$1"
