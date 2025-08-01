#!/bin/bash

declare SongsFolder="songs"
declare SongList=()
for file in "$SongsFolder"/*; do
	if [[ $file =~ \. ]]; then
		SongList+=($file)
	fi
done

echo "Song Library: "
for i in "${!SongList[@]}";
do
	declare -i num=i+1
	echo "$num. ${SongList[i]}"
done

echo "Enter song name or ID: "
read sid
declare sname
if [[ $sid =~ ^-?[0-9]+$  ]]; then
	# is a song ID
	sname=${SongList[sid - 1]}
else
	# is a song name
	if [[ $sid =~ \. ]]; then # abysmal regex use ik
		# means there is already a file extension in name
		sname="${SongsFolder}/${sid}"
	else
		sname="${SongsFolder}/${sid}.mp3" # im assuming mp3, if the user wanted to play a different extension that's on them ¯\_(ツ)_/¯
	fi
fi # I love how this is the closing for "if"

echo "Enter song volume: (leave empty for 8)"
read vol
if [[ -z "${vol}" ]]; then
	# is empty
	vol = "8"
fi
ffplay -vn -loop 0 -i "${sname}" -volume $vol
exit 0

