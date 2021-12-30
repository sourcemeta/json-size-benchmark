#!/bin/sh

set -o errexit
set -o nounset

if [ $# -lt 1 ]
then
  echo "Usage: $0 <output directory>" 1>&2
  exit 1
fi

OUTPUT_DIRECTORY="$1"

printf "\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n" \
  "Index" \
  "Format ID" \
  "Format Name" \
  "Uncompressed" \
  "GZIP (compression level 9)" \
  "LZ4 (compression level 9)" \
  "LZMA (compression level 9)"

INDEX=1
while IFS= read -r format
do
  FORMAT_NAME="$(cat "formats/$format/NAME")"

  printf "%s,%s,\"%s\",%s,%s,%s,%s\n" \
    "$INDEX" \
    "$format" \
    "$FORMAT_NAME" \
    "$(./scripts/byte-size.sh "$OUTPUT_DIRECTORY/$format/output.bin")" \
    "$(./scripts/byte-size.sh "$OUTPUT_DIRECTORY/$format/output.bin.gz")" \
    "$(./scripts/byte-size.sh "$OUTPUT_DIRECTORY/$format/output.bin.lz4")" \
    "$(./scripts/byte-size.sh "$OUTPUT_DIRECTORY/$format/output.bin.lzma")"

  # TODO: Order of compressed files should be as compression/ORDER!!

  INDEX="$((INDEX + 1))"
done < ./formats/ORDER
