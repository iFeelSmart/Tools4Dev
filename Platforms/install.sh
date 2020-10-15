#!/bin/sh
#### MODULE HEADER BLOC
# Generated From $Tools4Dev_PATH/Templates/function.env
# This documentation will be read and compile for man usage, MarkDown file and shell documentation
# v1.2
#
#   - Name:
#       Install Tools4Dev script
###
#   - Description:
#       This script should be run via curl:
#           sh -c "$(curl -fsSL https://raw.githubusercontent.com/ifeelsmart/tools4dev/master/platform/install.sh)"
#       or via wget:
#           sh -c "$(wget -qO- https://raw.githubusercontent.com/ifeelsmart/tools4dev/master/platform/install.sh)"
#       or via fetch:
#           sh -c "$(fetch -o - https://raw.githubusercontent.com/ifeelsmart/tools4dev/master/platform/install.sh)"
#
#
#       As an alternative, you can first download the install script and run it afterwards:
#           https://raw.githubusercontent.com/ifeelsmart/tools4dev/master/platform/install.sh
#           sh install.sh
#
#       Some variable on this script can be tweaked by setting them when running the script.
#           Tools4Dev_PATH=$HOME/.tools4dev sh install.sh
###
#   - Available Options:
#       * Tools4Dev_PATH            = Set Tools4Dev install path (default is $HOME/.tools4dev/src)
#       * INSTALL_ROOT              = On linux system, also create simlink for root user
#       * CSH                       = Configure zsh to be your default shell
#       * KEEP_ZSHRC                = if true do not install new zshrc file
#       * T4D_REMOTE                = set Tools4Dev Remote URL
#       * T4D_BRANCH                = set Tools4Dev branch to install
#       * T4D_REPO                  = set Tools4Dev Repo Path
#       * T4D_MANIFEST              = if not empty and valid, will download manifest file and link to it
#       
#
###
#   - Error Code:
#       402
###
#   - Supported Platform:
#       * OSX ( 10.12.6 or higher )
#       * Fedora ( 25 or higher )
###
#   - Author(s):
#       - Quentin NIO
#
###
#### HEADER BLOC ####
set -e

############################
T4D_REMOTE="${T4D_REMOTE:-}"
T4D_BRANCH="${T4D_BRANCH:-}"
T4D_REPO="${T4D_REPO:-}"
T4D_MANIFEST="${T4D_MANIFEST:-}"
T4D_ROOT_PATH="${T4D_ROOT_PATH:-$HOME/.tools4dev}"
Tools4Dev_PATH="${T4D_ROOT_PATH}/src"
INSTALL_ROOT="${INSTALL_ROOT:-false}"
CSH="${CSH:-true}"
KEEP_ZSHRC="${KEEP_ZSHRC:-false}"

############################



plog="\033[1;36m[LOG] \033[m"
psucceed="\033[1;32m[SUCCEED] \033[m"
pinfo="\033[1;35m[INFO]\033[m"
pskip="\033[1;35m[SKIPPED]\033[m"
perror="\033[1;31m [ERROR]\033[m"
pwarning="\033[1;33m [WARNING]\033[m"

_t4dDebugLog(){
    (>&2 echo "$(printf "%-4s" ' ')$1 ${@:2}" )
}

_t4dCheckCommand(){
    if [[ "$(command -v $1 2> /dev/null)" == "" ]]; then
        _t4dDebugLog $perror "command $1 not found"
        return 1
    fi
}

install_tools4dev(){
    
    _t4dCheckCommand git || exit 1

}

config_shell(){
    true
}

config_zshrc(){
    true
}

config_root(){
    if [[ -d "/root"]]; then
        _t4dDebugLog $pinfo "Requesting sudo rights to create simlink /root/.tools4dev -> $T4D_ROOT_PATH"
        sudo ln -sfn $T4D_ROOT_PATH /root/.tools4dev
    fi
}

main(){
    



    if [[ ! -d "$T4D_ROOT_PATH" ]]; then
        install_tools4dev
    else
        _t4dDebugLog $perror "Folder $T4D_ROOT_PATH already exist"
        exit 1
    fi
    

    if [[ "$CSH"          == "true"  ]]; then    config_shell; fi
    if [[ "$KEEP_ZSHRC"   == "false" ]]; then    config_zshrc; fi
    if [[ "$INSTALL_ROOT" == "true"  ]]; then    config_root; fi

}

main "$@"
