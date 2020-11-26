[<<< Back To Readme](../../../../README.md)
<p align="center">
    <img src="https://github.com/T4D-Suites/T4D-Ressources/blob/master/LogoGIK.png">
</p>


## Name
<p>gik</p>


## Synopsis
<p>Module used to manager several git projects through one command interface</p>


## Definition
<p>

Gik is a CommandLineTools utility that allow dev to use several Git projects as a unique project.
Moreover, it allows to quickly test low level lib modification on a highlevel project.
Gik want to increase flexiblity between projects

Gik stay close to git and use manifest.xml in order to clone and manage several git repositories.

When you use several projects at a time you will have to make some adjustement depending on your project.
There is 2 different behaviour that you need to have in mind:

* Custom Option
commit or push option for gik are quite different because you need ability to commit in several projects in one command.
Imagine that ou are fixing a bug in a high level application that need to changes file in a really low lvl libraries.
Gik will allow you to create a branch one both repositories and fix a bug as a global fix.
* Other
If you need to execute quick git command directly from a global workspace.
Gik will launch a different command depending on what you are saying to gik
- Known Options         -> Execute custom gik option command
- It's a file           -> Go to folder where file is then execute git command
- A folder              -> Go to folder then execute git command
- Something Else        -> Execute git command on all subrepositories defined in manifest.xml file
</p>


## Usage

* `gik <option>  **arguments**`

Will execute gik command with all arguments


* `gik help **option**`

Show Option documentation


## Options
- **status**
    - _Return a customized git status with beautiful output_
- **global-status**
    - _Return a global Workspace related status ->    commitSha7 RepoName BranchName_
- **branch-status**
    - _Explore all project from manifest and show gitPromptStatus_
- **log-status**
    - _Usefull tools to get info of current branch and others commit or branch_
        >        -commit
- **rebase**
    - _Allow user to rebase work of any branch to any other branch using cherry-pick method_
        >        -start-from         = Will cherry-pick all commit starting from this sha7 or branch
        >        -target             = select target branch
        >        -current            = select final sha7 or branch ( Default is HEAD)
        >        -create-branch      = Create new branches
        >        -pull               = Pull before doing anything
        >        -force              = Default will only send you a status. Use -f to apply modifications
        >        -logfile            = Override default log file
- **ws**
    - _Return workspaces informations concerning global variable and definitions_
- **sync**
    - _align all project branches from manifest.xml_
        >         -no-logo
- **shasync**
    - _Checkout all project using .diff information will be DETACHED_
- **push**
    - _Push your work in your global project and every sub-repositories_
        >        * -f
        >            Allow protected push
- **fpull**
    - _Force to Fetch & Pull in all manifest repositories_
- **tag**
    - _Create tag in All subrepositories + Project Manager Repository_
- **pull**
    - _Pull in all repositories that are behind remotes HEAD_
- **spull**
    - _Will pull sub directories only when current manifest branch is identical to Global Project Branch_
- **update**
    - _Update manifest.xml with current projects state_
- **origin**
    - _Edit default origin branch to current working branch_
- **commit**
    - _Launch multi repositories commit scenario_
        >        * -folders                      = Only commit in one folder
        >        * -force  | -f                  = Force commit
        >        * -branch | -b                  = Select which branch will be selected for commit
        >        * -message| -m                  = Add a 'OneLine' message for commit
- **checkout**
    - _Exec git checkout on file or sync projects_
- **all**
    - _Execute any command in 1 or several Folder_
- **fetch**
    - _Launch Silent Global Fetch_
- **folder**
    - _Execute any command in 1 or several Folder_
- **help**
    - _Show Project Documentation_
- **other**
    - _Apply command to File/Folder provided or apply git command in all sub repo
      _

## Example
<p>

* gika checkout             

>  Try to git checkout on all manifest repositories


* gik checkout              

>  Align all repositories depending on manifest information


* gik fpull                 

>  Pull on all repositories


* gik pull                  

>  Pull only repositories that are behind


* gik spull                 

>  Pull only repositories with branch different from origin


</p>

