#!/bin/sh

set -o errexit
set -o nounset

if [ $# -lt 1 ]
then
  echo "Usage: $0 <file>" 1>&2
  exit 1
fi

FILE="$1"

if [ "$(uname)" = "Darwin" ]
then
  stat -f '%z' "$FILE"
else
  stat -c '%s' "$FILE"
fi
