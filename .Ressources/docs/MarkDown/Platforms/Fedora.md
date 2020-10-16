 [<<< Back To Readme](../../../../README.md)
 <p align="center">
     <img src="https://image.ibb.co/mfkNxG/Screen_Shot_2018_01_02_at_10_55_58.png">
 </p>

 **Welcome to Tools4Dev !**

 Tools4Dev is a Command Line Tools that will help you to dynamicaly define 
 a custom development process and deploy it all among your team. 



## Name
<p>Fedora</p>


## Dependencies
```
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
which git-lfs || sudo dnf install -y git-lfs
which zsh || sudo dnf install -y zsh
sudo dnf install -y util-linux-user python libselinux-python patch jq
```


## Shared Folder
```
sudo mkdir -p /home/shared
cd /home/shared
sudo groupadd metnal
sudo chown $USER:metnal /home/shared
cd /home/shared
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


## Clone Deps
```
wks clone
```


## Documentation
```
t4dDoc
``** 

