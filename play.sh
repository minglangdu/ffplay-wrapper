#!/bin/bash

declare SongsFolder="songs"
#declare SongList=("TimeLeaper.mp3" "Isolation.mp3" "YouAndMe.mp3" "Retrospective.mp3" "FlawlessWingsofYatagarasu.mp3" "Surface.mp3" "ATSOL.mp3" "DarkMatterSuite.mp3" "Menace.mp3" "Stalemate.mp3" "DryOut.mp3")
declare SongList=()
for file in "$SongsFolder"/*; do
	if [[ $file =~ \. ]]; then
		SongList+=($file)
	fi
done

echo "Song Library: "
for i in $(seq 1 10);
do
	echo "$i. ${SongList[i - 1]}"
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

