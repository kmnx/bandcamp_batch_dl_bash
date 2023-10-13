#!/bin/zsh

# requires xld, if missing, install with:
# brew install xld

# requires bandcamp-collection-downloader.jar 
# from https://framagit.org/Ezwen/bandcamp-collection-downloader/-/releases

# requires bandcamp cookies.json in same directory as script
# see https://github.com/Ezwen/bandcamp-collection-downloader
xld
if [ $? -ne 0 ]; then
  echo "xld not installed, please run brew install xld and start it once to give execution permission"
  exit 1
fi

# set working directory to script location
cd "$(dirname "$0")"

# dl new files in flac format to /Volumes/T7/music_lossless_bandcamp
java -jar bandcamp-collection-downloader.jar -c=cookies.json -f=flac -d=/Volumes/T7/music_lossless_bandcamp knmx

# test if xld is working to prevent accidental deletion without conversion


# find every flac in /Volumes/T7 and convert to aiff
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