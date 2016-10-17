#!/bin/bash

set -e # exit on failure (same as -o errexit)

lsb_release -a
sudo apt-get -qq update

if [[ "$CC" == gcc-5 ]]; then
	sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
	sudo apt-get -qq update
	sudo apt-get install -qq g++-5
elif [[ "$CC" == gcc-6 ]]; then
	sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
	sudo apt-get -qq update
	sudo apt-get install -qq g++-6
fi

sudo apt-get -qq install libboost-dev

WITHLANG=$SWIGLANG

case "$SWIGLANG" in
	"")     ;;
	"csharp")
		sudo apt-get -qq install mono-devel
		;;
	"d")
		wget http://downloads.dlang.org/releases/2014/dmd_2.066.0-0_amd64.deb
		sudo dpkg -i dmd_2.066.0-0_amd64.deb
		;;
	"go")
		;;
	"javascript")
		case "$ENGINE" in
			"node")
                                which npm-install || true
                                which npm || true
                                which nvm || true
                                which node-gyp || true
                                echo "alias"
                                alias || true
                                echo "npm version"
                                npm --version || true
                                echo "nvm version"
                                nvm --version || true
                                nvm help || true
                                nvm ls || true
#                                nvm use v0.10.40 || true
                                echo "finished nvm use installed"
                                which node-gyp || true
                                which nodejs || true
                                echo "NVM_DIR: $NVM_DIR"
                                nvm alias * || true
                                echo "deactivate..."
                                nvm deactivate
                                nvm unload
                                ls ~/.nvm
                                rm -rf ~/.nvm
                                echo "install nodejs"
				sudo apt-get install -qq nodejs
				sudo apt-get install -qq node
                                echo "install npm"
				sudo apt-get install -qq npm
                                which npm || true
                                npm --version || true
                                echo "install node-gyp"
#				sudo apt-get install -qq node-gyp
				sudo npm install -g node-gyp
#				sudo npm install -g node-gyp@v0.10.40
                                echo "installed node-gyp"
                                which node-gyp || true
                                which nodejs || true
                                which node || true
                                node-gyp --version || true
                                nodejs --version || true
                                node --version || true
				;;
			"jsc")
				sudo apt-get install -qq libwebkitgtk-dev
				;;
			"v8")
				sudo apt-get install -qq libv8-dev
				;;
		esac
		;;
	"guile")
		sudo apt-get -qq install guile-2.0-dev
		;;
	"lua")
		if [[ -z "$VER" ]]; then
			sudo apt-get -qq install lua5.2 liblua5.2-dev
		else
			sudo add-apt-repository -y ppa:ubuntu-cloud-archive/mitaka-staging
			sudo apt-get -qq update
			sudo apt-get -qq install lua${VER} liblua${VER}-dev
		fi
		;;
	"ocaml")
		# configure also looks for ocamldlgen, but this isn't packaged.  But it isn't used by default so this doesn't matter.
		sudo apt-get -qq install ocaml ocaml-findlib
		;;
	"octave")
		if [[ -z "$VER" ]]; then
			sudo apt-get -qq install octave3.2 octave3.2-headers
		else
			sudo add-apt-repository -y ppa:kwwette/octaves
			sudo apt-get -qq update
			sudo apt-get -qq install liboctave${VER}-dev
		fi
		;;
	"php")
		sudo apt-get -qq install php5-cli php5-dev
		;;
	"python")
		sudo apt-get -qq install pep8
		if [[ "$PY3" ]]; then
			sudo apt-get install -qq python3-dev
		fi
		WITHLANG=$SWIGLANG$PY3
		if [[ "$VER" ]]; then
			sudo add-apt-repository -y ppa:fkrull/deadsnakes
			sudo apt-get -qq update
			sudo apt-get -qq install python${VER}-dev
			WITHLANG=$SWIGLANG$PY3=$SWIGLANG$VER
		fi
		;;
	"r")
		sudo apt-get -qq install r-base
		;;
	"ruby")
		set -x
		rvm list default ruby
		rvm list rubies
		rvm list strings
		rvm list known
		set +x
		if [[ "$VER" ]]; then
			rvm install $VER
		fi
		;;
	"scilab")
		sudo apt-get -qq install scilab
		;;
	"tcl")
		sudo apt-get -qq install tcl-dev
		;;
esac

set +e # turn off exit on failure (same as +o errexit)
