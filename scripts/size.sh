#!/bin/sh

set -o errexit
set -o nounset

ORDER="$1"
OUTPUT_DIRECTORY="$2"

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
UNCOMPRESSED_PATH="$OUTPUT_DIRECTORY/output.bin"
byte_size "$UNCOMPRESSED_PATH"

while IFS= read -r compressor
do
  byte_size "$UNCOMPRESSED_PATH.$compressor"
done < "$ORDER"
