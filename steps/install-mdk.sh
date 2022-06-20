#!/bin/sh

## Parameters

gh_action_path="$1"
renpy_version="$2"
mas_version="$3"
ddlc_url="$4"


## Directory structure

renpy="$gh_action_path/renpy"
mas="$gh_action_path/mas"


## Ren'Py SDK installation

mkdir "$renpy"
temp="$(mktemp -d)"

curl -fs "https://www.renpy.org/dl/$renpy_version/renpy-$renpy_version-sdk.tar.bz2" | tar xjC "$temp"
find "$temp" -mindepth 2 -maxdepth 2 -exec mv \{\} "$gh_action_path/renpy" \;

rm -r "$temp"


## DDLC pull

mkdir "$mas"
temp="$(mktemp -d)"

case "$ddlc_url" in
    http?://*drive.google.com/*) gdown --fuzzy -q -O "$temp/ddlc.zip" "$ddlc_url";;
    http?://*|ftp://*|sftp://*) curl -fq# -O "$temp/ddlc.zip" "$ddlc_url";;
esac

unzip -qo "$temp/ddlc.zip" -d "$temp"
rm "$temp/ddlc.zip"
find "$temp" -mindepth 2 -maxdepth 2 -exec mv \{\} "$mas" \;

rm -r "$temp"


## MAS pull

temp="$(mktemp -d)"

curl -sL "$(curl -sL "https://api.github.com/repos/monika-after-story/monikamoddev/releases/tags/$mas_version" | \
    perl -lne 'print $1 if /"browser_download_url": "(.+?-Mod\.zip)"/')" > "$temp/mas.zip"

unzip -qo "$temp/mas.zip" -d "$mas/game"

rm -r "$temp"