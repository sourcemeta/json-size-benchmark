#!/bin/sh

set -o errexit
set -o nounset

ORDER="$1"
UNCOMPRESSED_PATH="$2"

UNAME="$(uname)"
byte_size() {
  if [ "$UNAME" = "Darwin" ]
  then
    stat -f '%z' "$1"
  else
    stat -c '%s' "$1"
  fi
}

# Uncompressed always goes first
byte_size "$UNCOMPRESSED_PATH"

while IFS= read -r compressor
do
  byte_size "$UNCOMPRESSED_PATH.$compressor"
done < "$ORDER"
