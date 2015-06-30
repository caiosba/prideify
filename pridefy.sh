#!/bin/bash
# prideify.sh

usage () {
  echo 'Usage: ./prideify.sh [-r|-b|-p|-t] <input image file>. Output will be at <input image file>-pridified. The optional -r, -b, -p, or -t flags switch between rainbow, bisexual, pansexual, and transgender pride flags, with -r as the default.'
  exit -1
}
colors=('255,62,24' '252,154,0' '255,216,0' '57,234,124' '11,178,255' '152,90,255')
if [ $# -eq 1 ]; then
   image=$1
elif [ $# -eq 2 ]; then 
    case $1 in
        '-r' )
            ;;
        '-b' )
            colors=('214,2,112' '214,2,112' '155,79,150' '0,56,168' '0,56,168');;
        '-t' )
            colors=('91,206,250' '245,169,184' '255,255,255' '245,169,184' '91,206,250');;
        '-p' )
            colors=('255,46,140' '255,215,1' '34,177,255');;
        * )
            usage;;
    esac
    image=$2
else
    usage
fi

if [ -z $image ]
then
    usage
fi

width=$(identify $image | sed 's/.* \([0-9][0-9]*\)x\([0-9][0-9]*\) .*/\1/')
height=$(identify $image | sed 's/.* \([0-9][0-9]*\)x\([0-9][0-9]*\) .*/\2/')
tmp=$(mktemp 2>/dev/null || mktemp -t 'tmp')

cp $image $tmp


# rect height = ceil(height/# of rows) - 1, ceil to avoid an empty line across the bottom for non-divisible image heights and - 1 because each row starts a pixel below the previous one.
let "recth=($height - 1)/${#colors[@]}"

y1=0

for color in ${colors[@]}
do
  let "y2=$y1+$recth"
  convert $tmp -strokewidth 0 -fill "rgba($color,0.5)" -draw "rectangle 0,$y1 $width,$y2" $tmp
  let "y1=y2+1" # Stripes are non-overlapping.
done

mv $tmp "$image-prideified"
