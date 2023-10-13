#!/bin/zsh

/usr/local/Cellar/openjdk/20.0.2/bin/java -jar /Volumes/T7/bandcamp-collection-downloader.jar -c=/Volumes/T7/cookies.json -f=flac -d=/Volumes/T7/music_lossless_bandcamp knmx

IFS=$'\n'
paths=($(find /Volumes/T7 -name "*.flac"))
unset IFS

#printf "%s\n" "${paths[@]}"
for i in "${paths[@]}"
do
	echo "$i"
	opath="${i%/*}/"
	xld -o "$opath" -f aif $i
	rm $i
done



read  -n 1 -p "press key"