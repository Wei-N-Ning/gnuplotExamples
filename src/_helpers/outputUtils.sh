#!/usr/bin/env bash

# $1: source file path
function setPNGOutput() {
    if [ -d "${PNG_OUTPUT_DIR}" ]
    then
        local path=`generateName ${PNG_OUTPUT_DIR} $1`
        printf "set terminal pngcairo\nset output '${path}'\n"
    fi
}

# Given a file path such as /there/is/no/spoon.ext
# Generate a png file path: /output.../no_spoon.png
#
# Note:
# the name of the png file consists of the base name
# of the original path and the name of its containing
# directory
#
# $1: the output directory (e.g. /tmp/something)
# $2: a file path
function generateName() {
    local baseDir=${2%/*/*}
    local relPath=${2:${#baseDir}+1}
    local relPath=${relPath%.sh}
    local relPath="${1}/"${relPath//\//_}".png"
    printf ${relPath}
}
