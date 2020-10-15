 [<<< Back To Readme](../../../../README.md)
 <p align="center">
     <img src="https://image.ibb.co/mfkNxG/Screen_Shot_2018_01_02_at_10_55_58.png">
 </p>

 **Welcome to Tools4Dev !**

 Tools4Dev is a Command Line Tools that will help you to dynamicaly define 
 a custom development process and deploy it all among your team. 



## Name
<p>MacOS</p>


## Dependencies
```
brew install git-lfs zsh jq coreutils
git-lfs install
```


## Shared Folder
```
mkdir -p /Users/Shared
sudo chown $USER /Users/Shared
cd /Users/Shared
```


## Clone Tools4Dev
```
git clone {URL} Tools4Dev
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


## Zsh insecure folders
you might have an error during loading that tells you 
```
zsh compinit: insecure directories, run compaudit for list.
```
This can be fixed by using following command
```
compaudit | xargs chmod g-w
```


## Clone Deps
```
wks clone
```


## Documentation
```
t4dDoc
``** 

