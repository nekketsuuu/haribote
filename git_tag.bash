#!/bin/bash

set -e

if [ $# -lt 1 ] ; then
    echo "Usage (add today's tag): $0 <number of date>"
    echo "Usage (push tags):       $0 push"
    exit 1
fi

if [ "x$1" == "xpush" ] ; then
    git push origin --tags
    exit 0
fi

if [ ${#1} -ne 2 ] ; then
    echo "$0: ERROR: expected a 2-digit number, given '$1'"
    exit 1
fi

echo "$0: show last commit..."
echo
git log -1
echo
while true ; do
    read -p "Are you sure to add a tag 'day_$1' to this commit? [Y/n]" ans
    case "$ans" in
	'' | [Yy]* )
            git tag "day_$1" ;
	    break ;
	    ;;
	[Nn]* )
	    echo "$0: The answer is no; do nothing"
	    break ;
	    ;;
	* )
	    echo "Please answer yes or no"
    esac
done

