#!/usr/bin/env bash
#### MODULE HEADER BLOC
# Generated From $Tools4Dev_PATH/Templates/function.env
# This documentation will be read and compile for man usage, MarkDown file and shell documentation
# v1.2
#
#   - Name:
#       Install Tools4Dev script
###
#   - Default Install: 
#       Tools4Dev is configured to be working with a private repository called <Team-Folder>
#       You should first duplicate the Team-Default repository provided by T4D-Suites here :
#           https://github.com/T4D-Suites/T4D-Team-Default
#
#       IMPORTANT : If your organization already has a team repository, you might want to use it instead of Team-Default
#
#       <code>
#           cd $HOME/.tools4dev
#           git clone  git@github.com:T4D-Suites/T4D-Team-Default.git team-default
#           cd team-default
#           ./INSTALL
#       </code>
###
#   - Manual Install:
#       This script should be run via curl:
#           <code>
#               sh -c "$(curl -fsSL https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/main/Platforms/install.sh)"; zsh
#           </code>
#
#       As an alternative, you can first download the install script and run it afterwards:
#           Download : https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/main/Platforms/install.sh
#           <code>
#               sh install.sh
#               zsh
#           </code>
#
#       Some variable on this script can be tweaked by setting them when running the script.
#           <code>
#               Tools4Dev_PATH=$HOME/.tools4dev sh install.sh
#               sh -c "Tools4Dev_PATH=$HOME/.tools4dev; $(curl -fsSL https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/main/Platforms/install.sh)"; zsh
#           </code>
#
###
#   - Available Options:
#       * T4D_ROOT_PATH            = Set Tools4Dev install path (default is $HOME/.tools4dev)
#       * INSTALL_ROOT              = On linux system, also create simlink for root user
#       * CSH                       = Configure zsh to be your default shell
#       * T4D_REMOTE                = set Tools4Dev Remote URL
#       * T4D_CLONE_ARGS            = transfert args to wks clone
#       * T4D_NATIVE                = set to false if you don't want t4d to be natively loaded
#       * T4D_PROMPT                = set to false if you don't want t4d to load his own custom prompt
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
############################
set -e

plog="\033[1;36m[LOG] \033[m"
psucceed="\033[1;32m[SUCCEED] \033[m"
pinfo="\033[1;35m[INFO]\033[m"
pskip="\033[1;35m[SKIPPED]\033[m"
perror="\033[1;31m [ERROR]\033[m"
pwarning="\033[1;33m [WARNING]\033[m"

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


_t4dCheckCommand(){
    local _return=0
    for _command in $(echo $@); do
        if [[ "$(command -v $_command 2> /dev/null)" == "" ]]; then
            _t4dDebugLog $perror "command $_command not found"
            _return=1
        fi
    done
    return $_return
}
############################
_t4dCheckCommand zsh git jq chsh curl
if [[ "$(uname -s)" == "Darwin" ]]; then
    _t4dCheckCommand gdate
fi
############################

T4D_REMOTE="${T4D_REMOTE:-"https://github.com/T4D-Suites/"}"

T4D_CLONE_ARGS="${T4D_CLONE_ARGS}"
T4D_REPO="${T4D_REPO:-"Tools4Dev.git"}"
T4D_MANIFEST="${T4D_MANIFEST:-none}"

if [[ -e $T4D_MANIFEST ]]; then
    DEFAULT_T4D_BRANCH="$(cat $T4D_MANIFEST | grep '<team' | grep -Eo "branch=.*" | cut -d '=' -f2 | cut -d '"' -f2)"
else
    DEFAULT_T4D_BRANCH="${T4D_BRANCH:-main}"
fi

T4D_VERSION_SUFFIX="${T4D_VERSION_SUFFIX}"
T4D_BRANCH="${DEFAULT_T4D_BRANCH:-main}"
T4D_ROOT_PATH="${T4D_ROOT_PATH:-"$HOME/.tools4dev"}"
Tools4Dev_PATH="${T4D_ROOT_PATH}/src-devel"
FORCE_T4D_CLONE="${FORCE_T4D_CLONE:-false}"
T4D_NATIVE="${T4D_NATIVE:-undefined}"
T4D_PROMPT="${T4D_PROMPT:-true}"
CSH="${CSH:-false}"
ZSH_PATH="$(command -v zsh || true)"


install_tools4dev(){

    _t4dDebugLog $plog "Tools4Dev Installation"
    mkdir -p $Tools4Dev_PATH
    cd $T4D_ROOT_PATH
    git clone -b ${T4D_BRANCH} "${T4D_REMOTE}${T4D_REPO}" "$(basename $Tools4Dev_PATH)" && _t4dDebugLog $psucceed "Repository Cloned"
    if [[ -e "$HOME/.t4d-$USER-backup.env" ]]; then
        _t4dDebugLog $plog "Restoring t4d-$USER-backup file"
        cp "$HOME/.t4d-$USER-backup.env" "$T4D_ROOT_PATH/.$USER.env"
    fi

    echo "Patching VERSION with suffix $T4D_VERSION_SUFFIX"
    cat $Tools4Dev_PATH/VERSION |  sed "s|\$|$T4D_VERSION_SUFFIX|g" > $Tools4Dev_PATH/VERSION.tmp
    mv $Tools4Dev_PATH/VERSION.tmp $Tools4Dev_PATH/VERSION
}

config_shell(){
    $_su chsh -s "$ZSH_PATH" $1 && _t4dDebugLog $psucceed "Default shell ( $1 ) -> $ZSH_PATH"

}

config_rc(){
    local _prefix
    local _path="${1:-$T4D_ROOT_PATH}"
    local _oldRc=".t4drc_$(date +%Y-%m-%d_%H-%M-%S)"
    local _ZSHRC_PATH="/usr/bin/env"

    if [[ -e "$Tools4Dev_PATH/.t4drc" ]]; then
        _t4dDebugLog $plog "Creating $Tools4Dev_PATH/.t4drc backup's file in $Tools4Dev_PATH/$_oldRc"
        cp -f "$Tools4Dev_PATH/.t4drc" "$Tools4Dev_PATH/$_oldRc"
    fi

    _t4dDebugLog $plog ".t4drc Setup"
    if [[ -e "$_ZSHRC_PATH" ]]; then
        _ZSHRC_PATH="$_ZSHRC_PATH zsh"
    else
        _ZSHRC_PATH="$ZSH_PATH"
    fi
    cat "$Tools4Dev_PATH/Templates/t4drc.env" | sed "s|<T4D_ROOT_PATH>|$T4D_ROOT_PATH|g" \
                                                | sed "s|$HOME|\$HOME|g" \
                                                | sed "s|<T4D_NATIVE>|$T4D_NATIVE|g" \
                                                | sed "s|<T4D_USE_ZSHRC>|$T4D_USE_ZSHRC|g" \
                                                | sed "s|<T4D_PROMPT>|$T4D_PROMPT|g" \
                                                | sed "s|<ZSH_PATH>|$_ZSHRC_PATH|g" > "$Tools4Dev_PATH/.t4drc" \
                                                && _t4dDebugLog $psucceed "$Tools4Dev_PATH/Templates/t4drc.env copied in $Tools4Dev_PATH/.t4drc"

    cat $Tools4Dev_PATH/.t4drc
    
    t4d_link $_path


    _t4dDebugLog $plog ".zshenv Setup"
    if [[ "$(cat $HOME/.zshenv 2> /dev/null | grep 'Tools4Dev')" == "" ]]; then
        if [[ "$T4D_NATIVE" != "false" ]]; then
            if [[ "$T4D_NATIVE" == "undefined" ]]; then
                echo "Would you like to access T4D loaded natively for zsh ? Enter to proceed, any char to skip"
                read -N 1 T4D_NATIVE
            fi
            if [[ "${T4D_NATIVE:-true}" == "true" ]]; then 
                echo "#Tools4Dev" >> $HOME/.zshenv
                echo "if [[ -e \"$_path/.zshrc\" ]]; then" >> $HOME/.zshenv
                echo "  export ZDOTDIR=$_path" >> $HOME/.zshenv
                echo "fi" >> $HOME/.zshenv
            fi
        fi
    fi
}

t4d_link(){
    local _path="${1:-$T4D_ROOT_PATH}"
    cd $_path
    mkdir -p completions bin lib team
    if [[ "$Tools4Dev_PATH" != "$_path/src" ]]; then
        ln -sfvn "$Tools4Dev_PATH" "$_path/src"
    fi
    ln -sfvn "src/.t4drc" "${_path}/.zshrc"
    ln -sfvn "../src/t4d" "$_path/bin/t4d"
    ln -sfvn "src/Templates/init.env" "$_path/init"
    ln -sfvn "../src/Templates/Team-New" "$_path/team/Default"
    ln -sfvn "../src/Templates/Team-New/t4d-manifest.xml" "$_path/manifest.xml"
}

logo(){
    if [[ "$(echo -e toto)" == "toto" ]]; then
        echo -e "\033[1;32m            _____            _     _  _     ___           \033[m"
        echo -e "\033[1;32m           /__   \___   ___ | |___| || |   /   \_____   __\033[m"
        echo -e "\033[1;32m             / /\/ _ \ / _ \| / __| || |_ / /\ / _ \ \ / /\033[m"
        echo -e "\033[1;32m            / / | (_) | (_) | \__ \__   _/ /_//  __/\ V / \033[m"
        echo -e "\033[1;32m            \/   \___/ \___/|_|___/  |_|/___ / \___| \_/  \033[m"
        echo -e ""
    else
        echo "\033[1;32m            _____            _     _  _     ___           \033[m"
        echo "\033[1;32m           /__   \___   ___ | |___| || |   /   \_____   __\033[m"
        echo "\033[1;32m             / /\/ _ \ / _ \| / __| || |_ / /\ / _ \ \ / /\033[m"
        echo "\033[1;32m            / / | (_) | (_) | \__ \__   _/ /_//  __/\ V / \033[m"
        echo "\033[1;32m            \/   \___/ \___/|_|___/  |_|/___ / \___| \_/  \033[m"
        echo ""
    fi
}

clean_tools4dev(){
    if [[ -e "$T4D_ROOT_PATH/.$USER.env" ]]; then
        _t4dDebugLog $plog "Creating user back-up $HOME/.t4d-$USER-backup.env"
        cp "$T4D_ROOT_PATH/.$USER.env" "$HOME/.t4d-$USER-backup.env"
    elif [[ -e "$Tools4Dev_PATH/.$USER.env" ]]; then
        _t4dDebugLog $plog "Creating user back-up $HOME/.t4d-$USER-backup.env"
        cp "$Tools4Dev_PATH/.$USER.env" "$HOME/.t4d-$USER-backup.env"
    fi
    
    _t4dDebugLog $plog "Folder $T4D_ROOT_PATH will be deleted, enter to proceed or Ctrl+C to abort" && read
    rm -rf "${T4D_ROOT_PATH}"
}

main(){
    logo

    local _su=""
    if [[ "$(whoami)" != "root" ]]; then
        _t4dDebugLog $pinfo "Request sudo rights as $(whoami) to change default $1 shell -> $ZSH_PATH"
        _su="sudo"
    fi

    if [[ ! -d "${T4D_ROOT_PATH}/src" ]]; then
        install_tools4dev
    elif [[ "$FORCE_T4D_CLONE" == "true" ]]; then
        clean_tools4dev
        install_tools4dev
    elif [[ "$SKIP_T4D_CLONE" == "true" ]]; then
        _t4dDebugLog $pskip "Folder $T4D_ROOT_PATH already exist"
    else
        _t4dDebugLog $pskip "Folder $T4D_ROOT_PATH already exist"
        return 1
    fi
    
    config_rc $T4D_ROOT_PATH
    if [[ "$CSH"        == "true"  ]]; then    config_shell $USER; fi
    if [[ "$T4D_NATIVE" == "false" ]]; then
        _t4dDebugLog $plog "You can now add T4D to your path in your $HOME/.zshenv or .zshrc file"
        _t4dDebugLog $plog "echo \"export PATH=\$PATH:$T4D_ROOT_PATH/bin\" >> \$HOME/.zshenv"
    fi
}

main "$@"
