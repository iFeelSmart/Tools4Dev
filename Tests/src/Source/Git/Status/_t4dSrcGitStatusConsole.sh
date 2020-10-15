#! /bin/zsh

source $Tools4Dev_PATH/project.env &> /dev/null

local _BaseName="$(_t4dTestGetClassName $0)"
local _FunctionTested="_t4dSrcGitStatusConsole"

local _ROOT="$Tools4Dev_PATH/Tests/src"
local _DATA="$Tools4Dev_PATH/Tests/data/$_BaseName/${_FunctionTested}"
local _OUTPUT="$Tools4Dev_PATH/Tests/build"
local _ClassName="${_BaseName}"

local _TestFile="$_OUTPUT/$_BaseName-Result.xml"

local _Case1="$(       _t4dSrcGitStatusConsole "$(cat $_DATA/$_FunctionTested-Input)")"
local _Case2="$(       _t4dSrcGitStatusConsole "$(cat $_DATA/$_FunctionTested-Input)" "Prefix1")"

_t4dTestSuiteStart "$_TestFile" "2" 
      _t4dTestCase "$_TestFile" "$_BaseName" "  No Prefix" "$_Case1" "$(cat ${_DATA}/$_FunctionTested-Case1)"
      _t4dTestCase "$_TestFile" "$_BaseName" "With Prefix" "$_Case2" "$(cat ${_DATA}/$_FunctionTested-Case2)"
  _t4dTestSuiteEnd "$_TestFile"
    
