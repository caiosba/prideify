#!/bin/bash
# prideify.sh

image=$1

if [ -z $image ]
then
  echo 'Usage: ./prideify.sh <input image file>. Output will be at <input image file>-pridified.'
  exit 0
fi

width=$(identify $image | sed 's/.* \([0-9][0-9]*\)x\([0-9][0-9]*\) .*/\1/')
height=$(identify $image | sed 's/.* \([0-9][0-9]*\)x\([0-9][0-9]*\) .*/\2/')
tmp=$(mktemp 2>/dev/null || mktemp -t 'tmp')
colors='255,62,24 252,154,0 255,216,0 57,234,124 11,178,255 152,90,255'

cp $image $tmp

# rect height = ceil(height/# of rows), to avoid an empty line across the bottom for non-divisible image heights.
let "recth=($height - 1)/6 + 1"

y1=0

for color in $colors
do
  let "y2=$y1+$recth"
  convert $tmp -strokewidth 0 -fill "rgba($color,0.5)" -draw "rectangle 0,$y1 $width,$y2" $tmp
  let "y1=y2"
done

mv $tmp "$image-prideified"
