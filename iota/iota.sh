#!/bin/bash

# Array of files and directories to ignore
IGNORE=("svg" "build" "node_modules" "*.tmp" "*.log")

# Recursively walk through directories and collect files to process
_iota_walk() {
    local dir="$1"
    declare -n files_out_ref="$2"

    for item in "$dir"/*; do
        local basename=$(basename "$item")

        # Check if the item matches any ignore pattern
        for ignore in "${IGNORE[@]}"; do
            if [[ "$basename" == $ignore || "$item" == *"$ignore"* ]]; then
                continue 2  # Skip this item and go to the next
            fi
        done

        if [[ -d "$item" ]]; then
            # Recurse into subdirectories
            _iota_walk "$item" files_out_ref
        elif [[ -f "$item" ]]; then
            # Add files to the list
            files_out_ref+=("$item")
        fi
    done
}

# Compose files into a single output with headers
iota_compose() {
    local dir="$1"
    local -a files=()

    # Collect files recursively
    _iota_walk "$dir" files

    # Process each file and output to stdout
    for file in "${files[@]}"; do
        awk 'FNR==1 {
                 print "\n###############################"
                 print "# File: " FILENAME
                 print "###############################"
             }
             {print}' "$file"
    done
}

iota_build(){

export SEC1_HTML=$(cat sec1.html)
export SEC2_HTML=$(cat sec2.html)
export SEC3_HTML=$(cat sec3.html)
export REFS_HTML=$(cat refs.html)

buildname="index.html"
builddir="$PWD/build"
mkdir -p $builddir

cat ./index.env | envsubst > $builddir/$buildname 
cp -r  ./assets $builddir
cp ./styles.css $builddir/styles.css


SCRIPTPATH="$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )"
echo "Who:    $USER"
echo "What:   $builddir/$buildname"
echo "Where:  $SCRIPTPATH"
echo "When:   $(date)"
echo "How:    $BASH_SOURCE"

}
