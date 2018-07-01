#!/bin/bash

set -e

if [ $# -lt 1 ] ; then
    echo "$0: ERROR: Missing arguments. Expected one argument."
    echo "Usage:"
    echo "    Add today's tag: $0 <number of date>"
    echo "    Push tags:       $0 push"
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

TAG="day_$1"

echo "$0: Showing last commit..."
echo
git log -1
echo
while true ; do
    read -p "$0: Are you sure to add a tag '$TAG' to this commit? [Y/n]" ans
    case "$ans" in
	'' | [Yy]* )
	    # If the tag is already existed, consider to delete the tag by `git tag -d <tag>`.
	    # If it is already pushed, also consider to `git push --delete origin <tag>`.
            git tag "$TAG" || \
		{ echo "$0: ERROR: Failed to Add a tag. If the tag is already existed, consider to delete it by \`git tag -d $TAG\`. Also, if it is already pushed, consider to \`git push --delete origin $TAG\`." && exit 1 ; } ;
	    echo "$0: Succesfully tagged as '$TAG'!"
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

