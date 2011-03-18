#!/bin/bash
echo -e "\nJack has to be up and running\n"

# insert your desired filename below, extension will be added automatically
echo -n "Enter your desired videoname without [.avi] fileextension and hit <ENTER>: "
read SaveName

echo -e "\nchoose a window to capture or the desktop for fullscreen"
echo -e "\nto stop the script use <CTRL><C>"

INFO=$(xwininfo -frame)

WIN_GEO=$(echo "$INFO"|grep -e "Height:" -e "Width:"|cut -d\: -f2|tr "\n" " "|awk '{print $1 "x" $2}')
WIN_POS=$(echo "$INFO"|grep "upper-left"|head -n 2|cut -d\: -f2|tr "\n" " "|awk '{print $1 "," $2}')

ffmpeg -f jack -ac 2 -i ffmpeg -f x11grab -s $WIN_GEO -r 15 -i :0.0+$WIN_POS -acodec pcm_s16le -sameq "$SaveName.avi"

echo "$WIN_GEO -i :0.0+$WIN_POS -acodec"
echo "$WIN_POS"
