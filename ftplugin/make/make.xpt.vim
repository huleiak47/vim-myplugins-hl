XPTemplate priority=personal 

XPT shell
ifeq ($(OS),Windows_NT)
	SHELL := cmd.exe
else
	SHELL := /bin/sh
endif
`cursor^
