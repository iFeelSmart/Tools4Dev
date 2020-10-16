[<<< Back To Readme](../../../README.md)

<p align="center">
    <img src="https://image.ibb.co/eeAOuo/Screen_Shot_2018_06_28_at_16_22_56.png">
</p>

## Z Shell

##### Origin
Paul Falstad wrote the first version of Zsh in 1990, The name zsh derives from the name of Yale professor Zhong Shao, Zsh is an extended Bourne shell with a large number of improvements, including some features of Bash, ksh, and tcsh. Zsh has spell-checking, the ability to watch for logins/logouts, some built-in programming features like bytecode, support forscientific notation in syntax, allows for floating-point arithmetic, and more features.

##### How it works
Default Shell for major Operating System is Bourne Shell (sh). When you will first open any terminal you will have to tell him that launch zsh instead of default shell in preferences. 
You can also launch zsh manually after installation using `zsh` command.

## ZSH Init

##### Zshrc File
Once you launch zsh, it will source a file named .zshrc in you $HOME folder. If you use Tools4Dev .zshrc has a default content. In the following screenshot you can see important variable definition like `SHARED_WORKSPACE` or `Tools4Dev_PATH`. The most important line for Tools4Dev environment is line 16, `source $Tools4Dev_PATH/tools4Dev.env`, Here is our entry point for Tools4Dev environment.
<p>
    <img src="https://github.com/iFeelSmart/T4D-Ressources/blob/master/Zshrc.png">
</p>

##### Loading Tools4Dev

###### Custom User
In order to allow any user to have custom environment we decide to load by default Users.env files. This is here to help users to share their own prompt configuration and can also load O-My-ZSH plugins and lots of stuff. 
<p>
    <img src="https://github.com/iFeelSmart/T4D-Ressources/blob/master/User.png">
</p>

###### Chpwd Function
One of the important zsh features is chpwd function, indeed, anytime you move into another folder from your terminal zsh will launch this command in order to execute functions automaticaly. In the following screenshot you can see that anytime you will move into another directory it will source project.env file if exist. List available Folders/Files if not. 
<br>
<br>
NOTE : When you will move into another git workspace compatible with Tools4Dev, ZSH will automatically switch your working environment (overriding `WS_ROOT` variable), and let you use wks Commands that are designed for your new project. Manager can design and create different `wks doctor`, `wks finish`, `wks build` behavior to help user to do the right thing at the right time without knowing everything on this particular project.
<p>
    <img src="https://github.com/iFeelSmart/T4D-Ressources/blob/master/Chpwd.png">
</p>

###### Tools4Dev Common
This file (`$Tools4Dev_PATH/tools4Dev.env`) will also load all default Prompt command prefixed with _t4d value. All commands are name with specific Prefix to allow T4D Dev to find easily any command called in Modules. For Example, `_t4dSrcGitInfoBranchState` will be found in `$Tools4Dev_PATH/Source/Git/git-info.env` file. One Exception, Common functions are not Prefixed like others, `_t4dSystemLineCount` will be found in `$Tools4Dev_PATH/Common/system.env` file.