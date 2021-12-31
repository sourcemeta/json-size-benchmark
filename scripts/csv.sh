#!/bin/sh

set -o errexit
set -o nounset

FORMATS_ORDER="$1"
COMPRESSORS_ORDER="$2"
OUTPUT_DIRECTORY="$3"

printf "\"%s\",\"%s\",\"%s\",\"%s\"" \
  "Index" "ID" "Name" "Uncompressed"
while IFS= read -r compressor
do
  printf ",\"%s\"" "$(cat "compression/$compressor/NAME")"
done < "$COMPRESSORS_ORDER"
printf "\n"

INDEX=1
while IFS= read -r format
do
  printf "%s,%s,\"%s\"" "$INDEX" "$format" "$(cat "formats/$format/NAME")"
  while IFS= read -r size
  do
    printf ",%s" "$size"
  done < "$OUTPUT_DIRECTORY/$format/size.txt"
  printf "\n"
  INDEX="$((INDEX+1))"
done < "$FORMATS_ORDER"
