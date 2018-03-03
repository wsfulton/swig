#!/bin/bash

set -e # exit on failure (same as -o errexit)

sw_vers
travis_retry brew update
travis_retry brew list
# travis_retry brew install pcre # Travis Xcode-7.3 has pcre
# travis_retry brew install boost

WITHLANG=$SWIGLANG

case "$SWIGLANG" in
	"csharp")
		travis_retry brew install mono
		;;
	"guile")
		travis_retry Tools/brew-install guile
		;;
	"lua")
		travis_retry brew install lua
		;;
	"python")
		WITHLANG=$SWIGLANG$PY3
		if [[ "$PY3" ]]; then
			travis_retry brew install python@3
                        which python3 || echo "oops py3"
                        which python2 || echo "oops py2"
                        which python || echo "oops py"
                        python -V || echo "oops a"
                        python3 -V || echo "oops b"
			travis_retry brew list -v python@3
		fi
		;;
esac

# Workaround for https://github.com/travis-ci/travis-ci/issues/6522
set +e # turn off exit on failure (same as +o errexit)
