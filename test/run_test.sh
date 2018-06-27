#!/bin/sh

CMP=cmp
TARGET=./src/helloos.img
ORIG=./test/helloos.img

if [ ! -f "${ORIG}" ] ; then
    echo "$0: ERROR: The prepared file '${ORIG}' does not exist. Did you really run test on the project root?"
    exit 1
fi
if [ ! -f "${TARGET}" ] ; then
    echo "$0: ERROR: The target file '${TARGET}' is not found."
    exit 1
fi

if "${CMP}" "${TARGET}" "${ORIG}" ; then
    echo "$0: Equality test passed."
else
    echo "$0: ERROR: Equality test failed."
    exit 1
fi
