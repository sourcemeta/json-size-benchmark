#!/bin/sh

set -o errexit
set -o nounset

FORMATS_DIRECTORY="formats"
FORMATS="$(find "$FORMATS_DIRECTORY" -type d -mindepth 1 -exec basename {} \; | sort)"
ORDER="$(sort < "$FORMATS_DIRECTORY/ORDER")"

if [ "$FORMATS" != "$ORDER" ]
then
  echo "Format mismatch. The $FORMATS_DIRECTORY directory contains:" 1>&2
  echo "$FORMATS" 1>&2
  echo "However the ORDER file contains:" 1>&2
  echo "$ORDER" 1>&2
  exit 1
fi
