#!/bin/sh
mkdir source
mkdir done
mkdir work
timestamp=$(date +%s)
url=$3
fps=$1
delay=$2
input="${url##*/}"
extension="${input##*.}"
filename="${input%.*}"
output="$timestamp-$filename.gif"
cd source
rm *
wget $url
cd ..
cd work
rm *
palette="palette.png"
tempgif="temp.gif"
spritesheet="spritesheet.png"
lofisheet="lofi.png"
filters="hue=s=0,scale=w=160:h=144:force_original_aspect_ratio=decrease:flags=lanczos,fps=$fps"

ffmpeg -v warning -i ../source/$input -vf "$filters,palettegen=stats_mode=diff" -y $palette

ffmpeg -i ../source/$input -i $palette -lavfi "$filters,paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y $tempgif

montage $tempgif -coalesce -tile x1 -geometry +0+0 -alpha On -background "rgba(0, 0, 0, 0.0)" -quality 100 $spritesheet
convert $spritesheet -colors 4 -depth 4 -set colorspace Gray -separate -average $lofisheet
identify="$(identify -format '%wx%h\n' $tempgif | head -n1)"
convert -delay $delay -loop 0 $lofisheet -crop $identify +repage $output
echo 
echo syntax: ./go.sh fps delay downloadurl
cp $output ../done/$output
