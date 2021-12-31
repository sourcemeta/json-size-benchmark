#!/bin/sh

set -o errexit
set -o nounset

COMPRESSION_DIRECTORY="compression"
COMPRESSION="$(find "$COMPRESSION_DIRECTORY" -type d -mindepth 1 -exec basename {} \; | sort)"
ORDER="$(sort < "$COMPRESSION_DIRECTORY/ORDER")"

if [ "$COMPRESSION" != "$ORDER" ]
then
  echo "Compression mismatch. The $COMPRESSION_DIRECTORY directory contains:" 1>&2
  echo "$COMPRESSION" 1>&2
  echo "However the ORDER file contains:" 1>&2
  echo "$ORDER" 1>&2
  exit 1
fi
