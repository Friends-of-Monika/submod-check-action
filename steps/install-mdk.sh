#!/bin/sh

set -e

## Parameters

gh_action_path="$1"


## Directory structure

renpy="$gh_action_path/renpy"
mas="$gh_action_path/mas"
temp="$(mktemp -d)"


## mas-mdk image pulling

docker pull ghcr.io/friends-of-monika/mas-mdk:latest
docker run -d --rm --name mdk ghcr.io/friends-of-monika/mas-mdk:latest \
    /bin/sh -c "sleep 999999999"

docker export mdk -o "$temp/mdk.tar"
tar -xvf "$temp/mdk.tar" --directory "$temp" mdk

mv "$temp/mdk/mas" "$mas"
mv "$temp/mdk/renpy" "$renpy"