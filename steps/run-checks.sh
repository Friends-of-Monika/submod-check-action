#!/bin/sh

## Parameters

gh_action_path="$1"
submod_path="$2"

if [ -z "$submod_path" ]; then
    submod_path="$(dirname "$(find . -iname "*.rpy" -print -quit)")"
fi


## Directory structure

mas="$gh_action_path/mas"
mod="$mas/game/Submods"
renpy="$gh_action_path/renpy"


## Checks run

mkdir -p "$mod"

#shellcheck disable=SC2164
(cd "$submod_path"; find . -iname "*.rpy" -exec cp -r --parents \{\} "$mod" \;)

cleanup() {
    rm -rf "$mod"
    rm "$mas/errors.txt" "$mas/compile.log"
}
trap cleanup EXIT

"$renpy/renpy.sh" "$mas" compile 2>&1 \
    | tail -n +2 \
    | tee "$mas/compile.log" \
    | perl -sne 'print if (/^\Q$mod\E.*: \w*Warning/ || !/^game\//)' \
        -- -mod="$(realpath --relative-to="$mod" "$mod")" \
    | perl -spe 'print $1 if /^\Q$mod\E(.*)/' \
        -- -mod="$(realpath --relative-to="$mod" "$mod")"

if [ -f "$mas/errors.txt" ]; then exit 1; fi