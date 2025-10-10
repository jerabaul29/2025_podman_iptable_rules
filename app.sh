#!/bin/bash

# ----------------------------------------
# preamble

# exit if a command fails; to circumvent, can add specifically on commands that can fail safely: " || true "
set -o errexit
# make sure to show the error code of the first failing command
set -o pipefail
# do not overwrite files too easily
# to override the noclobber: >| instead of > only
set -o noclobber
# exit if try to use undefined variable
set -o nounset

# on globbing that has no match, return nothing, rather than return the dubious default ie the pattern itself
# see " help shopt "; use the -u flag to unset (while -s is set)
shopt -s nullglob

# ----------------------------------------

echo "Start app.sh"

echo ""
echo "Check access to 8.8.8.8"
nc -w 3 -z 8.8.8.8 53

echo ""
echo "Check access to 1.1.1.1"
nc -w 3 -z 1.1.1.1 53

echo ""
echo "End app.sh"
