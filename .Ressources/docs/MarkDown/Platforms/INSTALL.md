
## Name
<p>Install Tools4Dev script</p>


## Default Install
Tools4Dev is configured to be working with a private repository called <Team-Folder>
You should first duplicate the Team-Default repository provided by T4D-Suites here:
https://github.com/T4D-Suites/T4D-Team-Default

IMPORTANT : If your organization already has a team repository, you might want to use it instead of Team-Default

```
cd $HOME/.tools4dev
git clone  git@github.com:T4D-Suites/T4D-Team-Default.git team-default
cd team-default
./INSTALL
```


## Manual Install
This script should be run via curl:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/main/Platforms/install.sh)"; zsh
```

As an alternative, you can first download the install script and run it afterwards:
Download : https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/main/Platforms/install.sh
```
sh install.sh
zsh
```

Some variable on this script can be tweaked by setting them when running the script.
```
Tools4Dev_PATH=$HOME/.tools4dev sh install.sh
sh -c "Tools4Dev_PATH=$HOME/.tools4dev; $(curl -fsSL https://raw.githubusercontent.com/T4D-Suites/Tools4Dev/main/Platforms/install.sh)"; zsh
```


## Available Options
* T4D_ROOT_PATH            = Set Tools4Dev install path (default is $HOME/.tools4dev)
* INSTALL_ROOT              = On linux system, also create simlink for root user
* CSH                       = Configure zsh to be your default shell
* T4D_REMOTE                = set Tools4Dev Remote URL
* T4D_CLONE_ARGS            = transfert args to wks clone
* T4D_NATIVE                = set to false if you don't want t4d to be natively loaded
* T4D_PROMPT                = set to false if you don't want t4d to load his own custom prompt
* T4D_BRANCH                = set Tools4Dev branch to install
* T4D_REPO                  = set Tools4Dev Repo Path
* T4D_MANIFEST              = if not empty and valid, will download manifest file and link to it

