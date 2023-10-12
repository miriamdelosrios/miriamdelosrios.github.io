#!/bin/bash

# Example: ./resize_img.sh filename.jpg 1280 640 480 320

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

filename=$1
base_name=$(basename -- "$filename")
extension="${base_name##*.}"
image="${base_name%.*}"
path="${filename%$base_name}"
path="${path%%/}"
if [ -z $path ]; then path="."; fi

# echo "Filename: $filename"
# echo "Basename: $base_name"
# echo "Extension: $extension"
# echo "Image: $image"
# echo "Path: $path"
shift


if [ -z "$filename" ]; then
  echo "ERROR: You need to set the image filename to resize"
  exit 1
fi

if [ ! -f $filename ]; then
  echo "ERROR: Image '$filename' not found"
  exit 2
fi

if [ "$extension" != "jpg" ]; then
  echo "ERROR: Image extension is not .jpg"
  exit 3
fi

while (( "$#" )); do

width=$1
echo -n "$path/${image}_${width}.jpg ... "
if [ ! -f "$path/${image}_${width}.jpg" ]; then
  echo "convert -resize ${width}x $filename -quality 90"
  convert -resize ${width}x "$filename" -quality 90 "$path/${image}_${width}.jpg"
else
   echo "OK"
fi

shift

done
