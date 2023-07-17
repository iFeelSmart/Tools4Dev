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

_home="/Users/$USER"

if [[ ! -e "$_home" ]] &&  [[ -e "/home/$USER" ]]; then
    _home="/home/$USER"
else
    _t4dDebugLog $perror "HOME not supported"
    return 1
fi


if [[ "$(readlink $0)" != "" ]]; then
    _SRC_DIR="$(dirname "$(readlink $0)")"
elif [[ -e "$0/../src" ]]; then
    _SRC_DIR="$(dirname "$0")"
else
    _SRC_DIR="$_home/.tools4dev"
fi


home_setup(){
    local _T4DHomeFolder="$1"
    local _InstallDIR="$2"
    _t4dDebugLog "$plog" "Link $_InstallDIR to $_T4DHomeFolder"

    if [[ ! -e "$_T4DHomeFolder" ]]; then
        mkdir -p $_T4DHomeFolder
    fi

    cd $_T4DHomeFolder
    mkdir -p completions bin lib team
    _t4dDebugLog "$plog" "Tools4Dev source Link"
    if [[ "$_InstallDIR" != "$_T4DHomeFolder" ]] && [[ -e "${_InstallDIR}/src" ]]; then
        ln -sfvn "${_InstallDIR}/src" "$_T4DHomeFolder/src"
    elif [[ -e "${_InstallDIR}/src-devel" ]]; then
        ln -sfvn "${_InstallDIR}/src-devel" "$_T4DHomeFolder/src"
    else
        _t4dDebugLog $perror "No source found, could not create src link"
        return 1
    fi

    _t4dDebugLog "$plog" "Tools4Dev setup Link"
    ln -sfvn "src/.t4drc"                   "${_T4DHomeFolder}/.zshrc"
    ln -sfvn "../src/t4d"                   "${_T4DHomeFolder}/bin/t4d"
    ln -sfvn "src/Templates/init.env"       "${_T4DHomeFolder}/init"
    ln -sfvn "../src/Templates/Team-New"    "${_T4DHomeFolder}/team/Default"
    if [[ ! -e "${_T4DHomeFolder}/manifest.xml" ]]; then
        ln -sfvn "src/Templates/Team-New/t4d-manifest.xml" "${_T4DHomeFolder}/manifest.xml"
    fi
}

install(){
    local _InstallDIR="$1"
    if [[ -e "$_SRC_DIR/src" ]] && [[ "$_InstallDIR" != "$_home/.tools4dev" ]]; then
        mv "$_SRC_DIR/src" "$_InstallDIR/src"
    elif [[ "$_InstallDIR" == "$_home/.tools4dev" ]]; then
        if [[ -e "$_SRC_DIR/src-devel" ]] && [[ ! -e "$_prefix/src-devel" ]]; then
            rsync -a --progress "$_SRC_DIR/src-devel" "$_prefix"  \
                     --exclude .git \
                     --exclude .t4d \
                     --exclude Modules  \
                     --exclude Teams
        else
            _t4dDebugLog $perror "$_SRC_DIR/src-devel can't be duplicated to $_prefix"
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
    home_setup "$_home/.tools4dev" "$_prefix"
}

main $@