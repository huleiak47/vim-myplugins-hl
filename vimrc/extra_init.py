#!/usr/bin/env python
# -*- coding:utf-8 -*-

import os
import sys
import time
from pathlib import Path
import vim


def find_file(names):
    cwd = Path(os.getcwd()).absolute()
    while 1:
        for file in names:
            p = cwd / file
            if p.is_file():
                return p
        if cwd.parent == cwd:
            return None
        cwd = cwd.parent


def vim_init():
    viminit_file = find_file(['.viminit'])
    if viminit_file:
        vim.command(f'so {viminit_file}')


# load .viminit in current dir or parent dir when vim startup
vim.command("autocmd BufRead .viminit set ft=vim")
vim_init()


def find_ignore_file():
    FILES = ('.leaderfignore', '.gitignore', '.hgignore')
    return find_file(FILES)


def parse_ignore_file(fname):
    dirs = []
    files = []
    try:
        for line in fname.open("r", encoding="utf-8"):
            line = line.strip()
            if not line or line.startswith("#"):
                pass
            elif line.endswith("/"):
                dirs.append(line[:-1])
            else:
                dirs.append(line)
                files.append(line)
    except Exception as e:
        print(str(e), sys.stderr)

    return dirs, files


def leaderf_ignore_init():
    ignore_file = find_ignore_file()
    if not ignore_file:
        return

    dirs, files = parse_ignore_file(ignore_file)
    dirs.extend(['.git', '.svn', '.hg', '__pycache__'])

    COMMAND = r'''let g:Lf_WildIgnore = {'dir': %s, 'file': %s}''' % (
        str(dirs), str(files))
    vim.command(COMMAND)


# parse '.leaderfignore', '.gitignore', '.hgignore' in current dir or parent dir when vim startup
leaderf_ignore_init()


def save_colorscheme():
    with open(vim.eval("$HOME") + "/.colorscheme", "w") as f:
        f.write("colorscheme " + vim.eval("g:colors_name") + "\n")
        f.write("set bg=" + vim.eval("&bg") + "\n")


def init_colorscheme():
    if os.path.isfile(vim.eval("$HOME") + "/.colorscheme"):
        vim.command("source $HOME/.colorscheme")
    else:
        vim.command("colorscheme molokai")

    vim.command("autocmd ColorScheme * python3 save_colorscheme()")


# load colorscheme when startup, and save colorscheme when exit
init_colorscheme()
