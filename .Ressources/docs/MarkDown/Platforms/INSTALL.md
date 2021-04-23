
## Name
<p>Install Tools4Dev script</p>


## Description
This script should be run via curl:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/iFeelSmart/Tools4Dev/master/Platforms/install.sh)"; zsh

As an alternative, you can first download the install script and run it afterwards:
https://raw.githubusercontent.com/iFeelSmart/Tools4Dev/master/Platforms/install.sh
sh install.sh
zsh

Some variable on this script can be tweaked by setting them when running the script.
Tools4Dev_PATH=$HOME/.tools4dev sh install.sh
sh -c "Tools4Dev_PATH=$HOME/.tools4dev; $(curl -fsSL https://raw.githubusercontent.com/iFeelSmart/Tools4Dev/master/Platforms/install.sh)"; zsh


## Available Options
* Tools4Dev_PATH            = Set Tools4Dev install path (default is $HOME/.tools4dev/src)
* INSTALL_ROOT              = On linux system, also create simlink for root user
* CSH                       = Configure zsh to be your default shell
* KEEP_ZSHRC                = if true do not install new zshrc file
* T4D_REMOTE                = set Tools4Dev Remote URL
* T4D_NATIVE                = set to false if you don't want t4d to be natively loaded
* T4D_BRANCH                = set Tools4Dev branch to install
* T4D_REPO                  = set Tools4Dev Repo Path
* T4D_MANIFEST              = if not empty and valid, will download manifest file and link to it

