#!/bin/bash
SavePath="screencast02"

INFO=$(xwininfo -frame)

WIN_GEO=$(echo "$INFO"|grep -e "Height:" -e "Width:"|cut -d\: -f2|tr "\n" " "|awk '{print $1 "x" $2}')
WIN_POS=$(echo "$INFO"|grep "upper-left"|head -n 2|cut -d\: -f2|tr "\n" " "|awk '{print $1 "," $2}')
echo "$WIN_GEO -i :0.0+$WIN_POS -acodec"
echo "$WIN_POS"


ffmpeg -f jack -ac 2 -i ffmpeg -f x11grab -s $WIN_GEO -r 15 -i :0.0+$WIN_POS -acodec pcm_s16le -sameq "$SavePath.avi"

#ffmpeg -f jack -ac 2 -i ffmpeg -f x11grab -s $WIN_GEO -r 25 -i :0.0+$WIN_POS -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -sameq -threads 0 "$SavePath.mkv"

