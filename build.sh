#!/bin/sh

set -e

if [ -z "$1" ]; then
	echo "error: need to supply a project to build" >&2
	exit 1
fi

rm -r outputs/"$1"
mkdir outputs/"$1"
notangle -Routputs "$1" | while read -r file; do
	mkdir -p outputs/"$1"/"$(dirname "$file")"
	notangle -R"$file" "$1" > outputs/"$1"/"$file"
done

notangle -Rpostinstall "$1" > outputs/"$1"/postinstall

pushd outputs/"$1"
sh postinstall
popd

stow -doutputs -t"$HOME" "$1"
