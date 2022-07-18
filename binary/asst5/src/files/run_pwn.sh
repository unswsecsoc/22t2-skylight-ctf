#!/bin/sh

# Script to run the "pwn" binary in OS161

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

pwnbin="$(find -name pwn -type f | head -n1)"
if [ -z "$pwnbin" ]; then
	echo ERROR: Where is the pwn binary? Have you compiled it?
else
	sys161 kernel "p $pwnbin"
fi

popd
