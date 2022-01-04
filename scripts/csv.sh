#!/bin/sh

set -o errexit
set -o nounset

COMPRESSORS_ORDER="$1"
OUTPUT_DIRECTORY="$2"

printf "\"%s\",\"%s\",\"%s\",\"%s\"" \
  "Index" "ID" "Name" "Uncompressed"
while IFS= read -r compressor
do
  printf ",\"%s\"" "$(cat "compression/$compressor/NAME")"
done < "$COMPRESSORS_ORDER"
printf "\n"

for format in formats/*
do
  FORMAT_ID="$(basename "$format")"
  printf "%s,\"%s\"" "$FORMAT_ID" "$(cat "formats/$FORMAT_ID/NAME")"
  while IFS= read -r size
  do
    printf ",%s" "$size"
  done < "$OUTPUT_DIRECTORY/$FORMAT_ID/size.txt"
  printf "\n"
done
