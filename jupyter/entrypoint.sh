#!/bin/bash
DIR=$HOME/src/gaia
PYENV=$HOME/tetra/bin/pyenv
JSENV=$HOME/tetra/bin/nvm
source $PYENV/bin/activate
source "$JSENV/nvm.sh";
cd $DIR/jupyter
jupyter lab --no-browser \
	--ip=127.0.0.1 \
    --port=8888 \
	--notebook-dir=/home/latent
