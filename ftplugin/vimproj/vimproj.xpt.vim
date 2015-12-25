XPTemplate priority=personal

XPTinclude
    \ _common/common
    \ python/python

XPT temp
## This project file is a Python script.

## use NAME to set project name, if not set, file name will be used.
# NAME = 'name'

## use PATH to set file searching path. You can use * and ** to specify one or
## more dirs.
# PATH = ['./**']

## use SUFFIX to set suffix of source file.
# SUFFIX = ['.c', '.h']

## use TYPE to set project type, default SUFFIX, MAKE, COMPILER value will be
## set if you set a TYPE. Now you can choose a type in 'c', 'cpp', 'java',
## 'latex', 'vim', 'python'.
# TYPE = 'c'

## use MAKE to set command line for making project. When you press <F7>, make
## command will be execute.
# MAKE = 'make'

## use COMPILER to set errorformat of vim. Now you can choose one or more in
## 'common', 'msvc', 'gcc', 'mdk', 'ads', 'avr', 'javac', 'pclint', 'scons'
## 'pylint', 'yacc', 'lex'.
# COMPILER = ['common']

## use EXECUTE to set command line for dest file. When you press <F5>, the
## command you set will be executed.
# EXECUTE = ''

## use PAUSE to set whether pause executing after EXECUTE command is finished.
# PAUSE = 0

## use LIBTAGS to set whether load tags in library. Only for C/C++ project yet.
# LIBTAGS = 0

## use TAGS to set more tag files.
# TAGS = []

## If you set VIMCMD, this command will be executed by calling vim.command
## function after prject loaded.
# VIMCMD = ''

XPT jctemp
PATH = ['.', r'./src/**']
TYPE = 'java'
MAKE = 'scons'
COMPILER = ['javac']
VIMCMD = r'let g:java_classpath="C:/Python27/Lib/site-packages/jcbuilder/jclib/jc304/api.jar;C:/Python27/Lib/site-packages/jcbuilder/jclib/gp221/api.jar;C:/Python27/Lib/site-packages/jcbuilder/jclib/ftapi/api.jar"'
