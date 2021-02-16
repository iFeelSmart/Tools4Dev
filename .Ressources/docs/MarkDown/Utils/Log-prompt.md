[<<< Back To Readme](../../../../README.md)
<p align="center">
    <img src="https://github.com/T4D-Suites/T4D-Ressources/blob/master/LogoT4D.png">
</p>

# _t4dPromptIndent

## Synopsis
<p>|One-line description of what it does. (less than 55 char)|</p>


## Definition
<p>

Documentation Unavailable
</p>


## Usage
_t4dPromptIndent <NumberOfIndent> <Content>


## Example
<p>

</p>



# _t4dPromptSize

## Synopsis
<p>Get Terminal number of columns</p>


## Definition
<p>

Return Terminal number of columns, if variable COLUMNS does not exist, will return 100
you can divide this result with arg1
</p>


## Usage
_t4dPromptSize <Arg>


## Options

## Example
<p>

</p>



# _t4dPromptListInfo

## Synopsis
<p>Show a list of Variable name and contents</p>


## Definition
<p>

Linked to _t4dPromptInfo
</p>


## Usage
_t4dPromptListInfo "<List of Variable Names>" 17 ":" $plyellow


## Options

## Example
<p>

</p>



# _t4dPromptVarCenterWithChar

## Synopsis
<p>Fill variable with char to create a fixed lenght variable with value at center</p>


## Example
<p>

</p>



# _t4dPromptEchoTimer

## Synopsis
<p>Echo Timer that decrease his value until 1 + sleeping 1 seconds</p>


## Example
<p>

</p>



# _t4dPromptSquare

## Synopsis
<p>Generate pretty square with your string in it (and by string i mean variable)</p>


## Definition
<p>

Can be used anywhere in your code in order to generated a pretty console output
+-+-+-+-+-+-+
+ taratata  +
+-+-+-+-+-+-+
</p>


## Usage
_t4dPromptSquare **Options** <Args>


## Available Options
--no-color          = Remove all color code from output, used to write data in file


## Example
<p>

</p>



# _t4dPromptHyperLink

## Synopsis
<p>Show OutPut Line as HyperLink</p>


## Usage
_t4dPromptHyperLink <Link> <Name>



# _t4dPromptFixedCol

## Synopsis
<p>|One-line description of what it does. (less than 55 char)|</p>


## Example
<p>

</p>



# _t4dPromptTable

## Synopsis
<p>|One-line description of what it does. (less than 55 char)|</p>


## Example
<p>

</p>



# _t4dPromptChart

## Synopsis
<p>utils that will return a preformated table</p>


## Usage
_t4dPromptChart -start ""

_t4dPromptChart -data  ""

_t4dPromptChart -end   ""



