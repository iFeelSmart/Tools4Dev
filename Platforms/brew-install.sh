#!/usr/bin/env bash

set -e

#Testing echo statement to allow color management in output and avoid "-e" at beginning on line
if [[ "$(echo -e toto)" == "toto" ]]; then
    _t4dDebugLog(){
        echo -e "$(printf "%-4s" ' ')$1 ${@:2}"
    }
else
    _t4dDebugLog(){
        echo $(echo $echoArg) "$(printf "%-4s" ' ')$1 ${@:2}"
    }
fi

plog="\033[1;36m[LOG] \033[m"
psucceed="\033[1;32m[SUCCEED] \033[m"
pinfo="\033[1;35m[INFO]\033[m"
pskip="\033[1;35m[SKIPPED]\033[m"
perror="\033[1;31m [ERROR]\033[m"
pwarning="\033[1;33m [WARNING]\033[m"


install(){
    local _InstallDIR="$1"
    local _home="$2"
    local _suffix="$3"
    local _SRC_DIR="$PWD/src-devel"
    mkdir -p $_InstallDIR
    if [[ -e "$PWD/src-lts" ]] && [[ "$_InstallDIR" != "$_home/.tools4dev" ]] && [[ "$PWD" != "$_home/.tools4dev" ]]; then
        _SRC_DIR="$PWD/src-lts"
    elif [[ -e "$PWD/src" ]] && [[ "$_InstallDIR" != "$_home/.tools4dev" ]] && [[ "$PWD" != "$_home/.tools4dev" ]]; then
        _SRC_DIR="$PWD/src"
    elif [[ "$PWD" == "$_home/.tools4dev" ]]; then
        if [[ -e "$PWD/src-devel" ]] && [[ ! -e "$_InstallDIR/src-devel" ]]; then
            _SRC_DIR="$PWD/src-devel"
        else
            _t4dDebugLog $perror "$PWD/src-devel can't be duplicated to $_InstallDIR"
            return 1
        fi
    else
        _t4dDebugLog $perror "$PWD/src-lts does not exist"
        return 1
    fi

    rsync -a    --progress "$_SRC_DIR" "$_InstallDIR"  \
                --exclude .git \
                --exclude .t4d \
                --exclude Modules  \
                --exclude Teams
    if [[ "$(basename $_SRC_DIR)" != "src" ]] && [[ "$(basename $_SRC_DIR)" != "src-devel" ]]; then
        mv "$_SRC_DIR" "$_InstallDIR/src"
    fi

    mkdir -p $_InstallDIR/bin
    ln -sfvn "$_InstallDIR/src/t4d" "$_InstallDIR/bin/t4d${_suffix}"
}

main(){
    _prefix="$HOME/.tools4dev"
    _home="$HOME"
    _suffix=""
    while [[ "$@" != "" ]]; do
        case "$1" in
            --prefix*)
                _prefix="$(echo $1 | cut -d '=' -f2)"
            ;;
            --home*)
                _home="$(echo $1 | cut -d '=' -f2)"
            ;;
            --devel)
                _suffix="-devel"
            ;;
        esac
        shift
    done

    install "$_prefix" "$_home" "$_suffix"
}

main $@