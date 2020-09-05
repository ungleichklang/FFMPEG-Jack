#!/bin/bash

#checking if Jackd is running
if ps ax | grep -v grep | grep jackd > /dev/null
then
	echo -e "Jack is up and running "
else
	echo -e "Jack is not running, please start jack before you go on "
fi

#checking if ffmpeg can handle jack
if ! ffmpeg -formats |& grep jack > /dev/null
then
	echo -e "FFmpeg is not compiled with jack"
	exit
fi

# insert your desired filename below, extension will be added automatically
echo -n "Enter your desired videoname without [.mp4] fileextension and hit <ENTER>: "
read SaveName

echo -e "\nchoose a window to capture or the desktop for fullscreen"
echo -e "\nto stop the script use <CTRL><C>"

INFO=$(xwininfo -frame)

WIN_GEO=$(echo "$INFO"|grep -e "Height:" -e "Width:"|cut -d\: -f2|tr "\n" " "|awk '{print sprintf("%.0f",$1/2)*2 "x" sprintf("%.0f",$2/2)*2}')
WIN_POS=$(echo "$INFO"|grep "upper-left"|head -n 2  |cut -d\: -f2|tr "\n" " "|awk '{print $1 "," $2}')

ffmpeg -f jack -ac 2 -i ffmpeg -f x11grab -s $WIN_GEO -r 15 -i :0.0+$WIN_POS -c:a libopus -b:a 96k -ar 48000 -c:v libx264 -profile:v high444 -crf 30 -trellis 2 -direct-pred auto -bf 16 "$SaveName.mp4"

echo "$WIN_GEO -i :0.0+$WIN_POS -acodec"
echo "$WIN_POS"
