#!/bin/bash

declare SongsFolder="songs"
declare SongList=("FlawlessWingsofYatagarasu.mp3" "Surface.mp3" "ATSOL.mp3" "DarkMatterSuite.mp3" "Menace.mp3" "Stalemate.mp3" "DryOut.mp3")

echo "Enter song name or ID: "
read sid
declare sname
if [[ $sid =~ ^-?[0-9]+$  ]]; then
	# is a song ID
	sname=${SongList[sid]}
else
	# is a song name
	if [[ $sid =~ \. ]]; then # abysmal regex use ik
		# means there is already a file extension in name
		sname=sid
	else
		sname="${sid}.mp3" # im assuming mp3, if the user wanted to play a different extension that's on them ¯\_(ツ)_/¯
	fi
fi # I love how this is the closing for "if"

ffplay -loop 0 -i -volume 8 "${SongsFolder}/${sname}"
exit 0

