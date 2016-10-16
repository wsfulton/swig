#!/bin/bash

set -e # exit on failure

sw_vers
brew update
brew list
# brew install pcre # Travis Xcode-7.3 has pcre
# brew install boost

WITHLANG=$SWIGLANG

case "$SWIGLANG" in
	"csharp")
		Tools/brew-install mono
		;;
	"guile")
		Tools/brew-install guile
		;;
	"lua")
		brew install lua
		;;
	"python")
		WITHLANG=$SWIGLANG$PY3
		if [[ "$PY3" ]]; then
			brew install python3
			brew list -v python3
		fi
		;;
esac
