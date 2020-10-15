#! /bin/zsh

source $Tools4Dev_PATH/project.env &> /dev/null

local _BaseName="$(_t4dTestGetClassName $0)"
local _FunctionTested="t4ddm"

local _ROOT="$Tools4Dev_PATH/Tests/src"
local _DATA="$Tools4Dev_PATH/Tests/data/$_BaseName/${_FunctionTested}"
local _OUTPUT="$Tools4Dev_PATH/Tests/build"

local _TestFile="$_OUTPUT/$_BaseName-Result.xml"

local _Case1="$(       t4ddm $(cat $_DATA/$_FunctionTested-Input) 2>&1 )"
local _Case2="$(       t4ddm $(cat $_DATA/$_FunctionTested-Input2) 2>&1 )"

_t4dTestSuiteStart "$_TestFile" "1" 
      _t4dTestCase "$_TestFile" "$_BaseName" "Test with echo" "$_Case1" "$(cat $_DATA/$_FunctionTested-Case1)"
      _t4dTestCase "$_TestFile" "$_BaseName" "Test with _t4dPromptSquare" "$_Case2" "$(cat $_DATA/$_FunctionTested-Case2)"
  _t4dTestSuiteEnd "$_TestFile"
