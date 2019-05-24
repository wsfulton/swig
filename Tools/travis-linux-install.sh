#!/bin/bash

# Install Linux packages where the version has been overidden in .travis.yml

set -e # exit on failure (same as -o errexit)

lsb_release -a
travis_retry sudo apt-get -qq update

if [[ -n "$GCC" ]]; then
	travis_retry sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
	travis_retry sudo apt-get -qq update
	travis_retry sudo apt-get install -qq g++-$GCC
fi

travis_retry sudo apt-get -qq install libboost-dev

WITHLANG=$SWIGLANG

case "$SWIGLANG" in
	"")     ;;
	"csharp")
		travis_retry sudo apt-get -qq install mono-devel
		;;
	"d")
		travis_retry wget http://downloads.dlang.org/releases/2014/dmd_2.066.0-0_amd64.deb
		travis_retry sudo dpkg -i dmd_2.066.0-0_amd64.deb
		;;
	"go")
		if [[ "$VER" ]]; then
		  eval "$(gimme ${VER}.x)"
		fi
		;;
	"javascript")
		case "$ENGINE" in
			"node")
				travis_retry wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.10/install.sh | bash
				export NVM_DIR="$HOME/.nvm"
				[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
				travis_retry nvm install ${VER}
				nvm use ${VER}
				if [ "$VER" == "0.10" ] || [ "$VER" == "0.12" ] ; then
#					travis_retry sudo apt-get install -qq nodejs node-gyp
					travis_retry npm install -g node-gyp@$VER
				else
					travis_retry npm install -g node-gyp
				fi
				;;
			"jsc")
				travis_retry sudo apt-get install -qq libwebkitgtk-dev
				;;
			"v8")
				travis_retry sudo apt-get install -qq libv8-dev
				;;
		esac
		;;
	"guile")
		travis_retry sudo apt-get -qq install guile-2.0-dev
		;;
	"lua")
		if [[ -z "$VER" ]]; then
			travis_retry sudo apt-get -qq install lua5.2 liblua5.2-dev
		else
			travis_retry sudo apt-get -qq install lua${VER} liblua${VER}-dev
		fi
		;;
	"mzscheme")
		travis_retry sudo apt-get -qq install racket
		;;
	"ocaml")
		travis_retry sudo apt-get -qq install ocaml camlp4
		;;
	"octave")
		if [[ -z "$VER" ]]; then
			travis_retry sudo apt-get -qq install liboctave-dev
		elif [[ "$VER" == "5" ]]; then
			travis_retry sudo add-apt-repository ppa:alexlarsson/flatpak
			echo "flatpak step 1"
			time travis_retry sudo apt-get install flatpak
			echo "flatpak step 2"
			time travis_retry flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
			echo "flatpak step 3"
			time travis_retry flatpak install flathub org.octave.Octave
			echo "flatpak step 4"
		else
			# Travis adds external PPAs which contain newer versions of packages
			# than in baseline trusty. These newer packages prevent some of the
			# Octave packages in ppa:kwwette/octave, which rely on the older
			# packages in trusty, from installing. To prevent these kind of
			# interactions arising, clean out all external PPAs added by Travis
			# before installing Octave
			sudo rm -rf /etc/apt/sources.list.d/*
			travis_retry sudo apt-get -qq update
			travis_retry sudo add-apt-repository -y ppa:kwwette/octaves
			travis_retry sudo apt-get -qq update
			travis_retry sudo apt-get -qq install liboctave${VER}-dev
		fi
		;;
	"php")
		travis_retry sudo add-apt-repository -y ppa:ondrej/php
		travis_retry sudo apt-get -qq update
		travis_retry sudo apt-get -qq install php$VER-cli php$VER-dev
		;;
	"python")
		pip install --user pycodestyle
		if [[ "$PY3" ]]; then
			travis_retry sudo apt-get install -qq python3-dev
		fi
		WITHLANG=$SWIGLANG$PY3
		if [[ "$VER" ]]; then
			travis_retry sudo add-apt-repository -y ppa:deadsnakes/ppa
			travis_retry sudo apt-get -qq update
			travis_retry sudo apt-get -qq install python${VER}-dev
			WITHLANG=$SWIGLANG$PY3=$SWIGLANG$VER
		fi
		;;
	"r")
		travis_retry sudo apt-get -qq install r-base
		;;
	"ruby")
		rvm list
		rvm list known
		if [[ "$VER" ]]; then
			travis_retry rvm install $VER
		fi
		;;
	"scilab")
		echo "JAVA_HOME was set to $JAVA_HOME"
		unset JAVA_HOME
		travis_retry sudo apt-get -qq install scilab
		;;
	"tcl")
		travis_retry sudo apt-get -qq install tcl-dev
		;;
esac

set +e # turn off exit on failure (same as +o errexit)
