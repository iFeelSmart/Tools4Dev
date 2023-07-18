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
    mkdir -p $_InstallDIR
    if [[ -e "$_SRC_DIR/src" ]] && [[ "$_InstallDIR" != "$_home/.tools4dev" ]] && [[ "$_SRC_DIR" != "$_home/.tools4dev" ]]; then
        mv "$_SRC_DIR/src" "$_InstallDIR/src"
    elif [[ "$_SRC_DIR" == "$_home/.tools4dev" ]]; then
        if [[ -e "$_SRC_DIR/src-devel" ]] && [[ ! -e "$_InstallDIR/src-devel" ]]; then
            rsync -a --progress "$_SRC_DIR/src-devel" "$_InstallDIR"  \
                     --exclude .git \
                     --exclude .t4d \
                     --exclude Modules  \
                     --exclude Teams
        else
            _t4dDebugLog $perror "$_SRC_DIR/src-devel can't be duplicated to $_InstallDIR"
            return 1
        fi
    else
        _t4dDebugLog $perror "$_SRC_DIR/src-lts does not exist"
        return 1
    fi
}

main(){
    _prefix="$_home/.tools4dev"
    while [[ "$@" != "" ]]; do
        case "$1" in
            --prefix*)
                _prefix="$(echo $1 | cut -d '=' -f2)"
            ;;

            --home*)
                _home="$(echo $1 | cut -d '=' -f2)"
            ;;
        esac
        shift
    done

    install "$_prefix"
    # home_setup "$_home/.tools4dev" "$_prefix"
}

main $@