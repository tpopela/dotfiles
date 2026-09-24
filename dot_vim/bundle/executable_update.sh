#!/bin/sh

pushd $HOME/.vim/bundle > /dev/null
for d in *
do
	if [ -d $d ]; then
		echo "Checking $d"
		pushd $d > /dev/null && git pull && popd > /dev/null
	fi
done
popd > /dev/null
