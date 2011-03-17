#!/bin/bash

# insert your desired filename below, extension will be added automatically
SavePath="screencast02"

INFO=$(xwininfo -frame)

WIN_GEO=$(echo "$INFO"|grep -e "Height:" -e "Width:"|cut -d\: -f2|tr "\n" " "|awk '{print $1 "x" $2}')
WIN_POS=$(echo "$INFO"|grep "upper-left"|head -n 2|cut -d\: -f2|tr "\n" " "|awk '{print $1 "," $2}')

ffmpeg -f jack -ac 2 -i ffmpeg -f x11grab -s $WIN_GEO -r 15 -i :0.0+$WIN_POS -acodec pcm_s16le -sameq "$SavePath.avi"

echo "$WIN_GEO -i :0.0+$WIN_POS -acodec"
echo "$WIN_POS"
