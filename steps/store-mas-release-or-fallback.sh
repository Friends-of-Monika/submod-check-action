#!/bin/sh

## Parameters

mas_release="$1"


## If MAS release is not set, use latest

if [ -z "$mas_release" ]; then
    echo "::set-output name=mas-release::$(curl -sL "https://api.github.com/repos/monika-after-story/monikamoddev/releases/latest" | \
        perl -lne 'print $1 if /"browser_download_url": "(.+?-Mod\.zip)"/')"
else
    echo "::set-output name=mas-release::$mas_release"
fi