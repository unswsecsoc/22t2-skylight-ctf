#!/bin/sh

# Script used to compile the userland program "pwn.c"

# Exit on non-zero return status
set -e

if [ "$#" != 2 ]; then
	echo Usage: $0 '<path/to/os161>' '<path/to/tools>'
	exit 1
fi

os161path="$(realpath "$1")"
toolspath="$(realpath "$2")"

PATH="$PATH":"$toolspath/os161/bin"
PATH="$PATH":"$toolspath/sys161/bin"

pushd "$os161path"
bmake
popd

binpath="$(find "$os161path" -name pwn -type f -print -quit)"
echo '**********'
echo '*' Compiled pwn binary: "$binpath"
echo '**********'
