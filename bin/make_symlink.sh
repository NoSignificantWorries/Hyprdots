#!/bin/sh

FILE_PATH="$1"
SYMLINK_PATH="$2"

if [ -z "$FILE_PATH" ]; then
  exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
  exit 1
fi

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION="${FILE_EXTENSION,,}"

if [[ "$FILE_EXTENSION" != "png" && "$FILE_EXTENSION" != "jpg" ]]; then
  exit 1
fi

ln -sf "$FILE_PATH" "$SYMLINK_PATH"

exit 0

