[<<< Back To Readme](../../../../README.md)
<p align="center">
    <img src="https://github.com/T4D-Suites/T4D-Ressources/blob/master/LogoT4D.png">
</p>

 **Welcome to Tools4Dev !**

 Tools4Dev is a Command Line Tools that will help you to dynamicaly define 
 a custom development process and deploy it all among your team. 



## Name
<p>Alpine</p>


## Dependencies
Enable community repositories in /etc/apk/repositories then
```
apk update && apk upgrade
apk add zsh git python2
```


## Shared Folder
```
mkdir -p /home/shared
cd /home/shared
```


## Clone Tools4Dev
```
git clone {URL} --single-branch Tools4Dev
cd Tools4Dev
```


## Install Zshrc
Please choose One:

* If you already have Oh-My-ZSH and don't want to override your current .zshrc file
```
./t4d install append
zsh
```
* If doesn't care
```
./t4d install
zsh
```


## Clone Deps
```
wks clone
```


## Documentation
```
t4dDoc
``** 

