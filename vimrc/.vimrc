set nocompatible
filetype off

let g:isWin=(has("win32") || has("win64") || has("win32unix"))
let g:isGUI=has("gui_running")
let $vimrc = $HOME . "/.vimrc"

" vundle plugins
execute 'set rtp+=' . $VIM . '/plugins/vundle'
call vundle#rc($VIM . '/plugins')

"first time use git clone https://github.com/gmarik/vundle.git  ~/.vim/plugins/vundle to get vundle
"
" Plugins
Plugin 'gmarik/vundle'

Plugin 'huleiak47/vim-myplugins-hl'
Plugin 'huleiak47/vim-RelatedFile'
Plugin 'huleiak47/vim-AHKcomplete'
Plugin 'huleiak47/vim-SimpleIDE'
Plugin 'Align'
Plugin 'bling/vim-airline'
Plugin 'clang-complete'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'netrw.vim'
Plugin 'Tagbar'
Plugin 'VOom'
Plugin 'vimcaps'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'xptemplate'
Plugin 'CmdlineComplete'
Plugin 'DoxygenToolkit.vim'
Plugin 'Mark'
Plugin 'Raimondi/delimitMate'
Plugin 'davidhalter/jedi-vim'
Plugin 'youjumpiwatch/vim-javacomplete'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'

" --------------------------------------------------------

let mapleader = "'"


function! MyDiff()
    let opt = '-a -d --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if g:isWin
        let cmd = 'diff.exe'
    else
        let cmd = 'diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
set diffexpr=MyDiff()

syntax on
filetype on
filetype plugin on
filetype indent on

"python接口

python << EOF_PYTHON

import vim
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
import os
import re

#格式化代码文件
def FormatCode(tp):
    ft = vim.eval('&filetype')
    line = int(vim.eval('line(".")'))
    col = int(vim.eval('col(".")'))
    vim.command('normal H')
    vim.command('normal mx')
    if ft in ('c', 'cpp', 'java', 'cs'):
        if tp == 0: #format all code
            vim.command('%!astyle_c')
        else:
            vim.command("'<,'>!astyle_c")
    elif ft in ('xml',):
        if tp == 0:
            vim.command("%!xmlformat")
        else:
            vim.command("'<,'>!xmlformat")
    elif ft in ('html',):
        if tp == 0:
            vim.command("%!htmlformat")
        else:
            vim.command("'<,'>!htmlformat")
    elif ft in ('python',):
        tenc = vim.eval('&termencoding')
        enc = vim.eval('&encoding')
        cmds = []
        if tp == 0:
            cmds.append("%!")
        else:
            cmds.append("'<,'>!")
        if tenc != enc:
            cmds.append("recoding %s | " % tenc)
        cmds.append("autopep8 -a -")
        if tenc != enc:
            cmds.append(" | recoding %s" % enc)
        vim.command("".join(cmds))

    else:
        print >> sys.stderr, "Format code: file type not supported!"
    vim.command('normal `x')
    vim.command('normal zt')
    vim.command('call setpos(".", [0, %d, %d, 0])' % (line, col))

def change_guifont_size(inc = True):
    guifont = vim.eval("&guifont")
    guifontwide = vim.eval("&guifontwide")
    ptn = re.compile("^(.*:h)(\d+)$")
    cmds = []
    for font, name in [(guifont, "guifont"), (guifontwide, "guifontwide")]:
        mobj = ptn.match(font)
        if mobj:
            fontsize = int(mobj.group(2))
            if inc:
                if fontsize < 40:
                    fontsize += 1
                else:
                    return
            else:
                if fontsize > 1:
                    fontsize -= 1
                else:
                    return
            cmds.append("set {}={}{:d}".format(name, mobj.group(1), fontsize))
    for cmd in cmds:
        vim.command(cmd)

EOF_PYTHON

nnoremap <silent> <C-PageUp> :python change_guifont_size(True)<CR>
nnoremap <silent> <C-PageDown> :python change_guifont_size(False)<CR>

"==================================================================
"通用的配置
autocmd FileType dosbatch setl fileformat=dos | setl fenc=gbk
if g:isWin
    "set shellslash
    set fencs=ucs-bom,utf-8,gbk,big5,latin-1
    if &fenc == "" && &modifiable
        set fenc=utf-8
    endif
    set fileformats=unix,dos
    if g:isGUI
        set encoding=utf-8
        set ambiwidth=double
        "set guifont=droid_sans_mono:h11
        set guifont=Consolas:h11
        set guifontwide=SimHei:h11
        set linespace=0
        set nocursorline "高亮当前行
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        "language messages zh_CN.utf-8
        language messages en_US.utf-8
    else
        language messages en_US.utf-8
        set encoding=gbk
        colorscheme neon
        set nocursorline
    endif
    set termencoding=gbk
else
    set guifont=DejaVu\ Sans\ Mono\ 11
    "set guifontwide=WenQuanYi\ Zen\ Hei\ 12
    set guifontwide=文泉驿等宽微米黑\ 12
    set linespace=0
    set fencs=ucs-bom,utf-8,gb18030,big5,latin-1,utf-16
    if &fenc == "" && &modifiable
        set fenc=utf-8
    endif
    set encoding=utf-8
    set termencoding=utf-8
    set fileformats=unix,dos
    if g:isGUI
        "colorscheme wombat256
    else
        colorscheme neon
    endif
endif

if g:isWin
    function! ChangeEUCCNtoGBK()
        if &fenc == "euc-cn" && &modifiable == 1
            set fenc=gbk
        endif
    endfunction
    au BufRead * call ChangeEUCCNtoGBK()
endif

if g:isGUI && !exists("s:has_inited")
    let s:has_inited = 1
    set lines=45 columns=160
endif

set textwidth=0
set hidden
set fdl=10
set numberwidth=5
set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType tex setl tabstop=2 | setl softtabstop=2 | setl shiftwidth=2
set smarttab
set autoindent
autocmd FileType c,cpp,java,cs,javascript,php setl smartindent cindent
set nolinebreak
autocmd FileType * setl nolinebreak
set nobackup
set nowb
set ignorecase
set smartcase
set wrap
set showcmd
set autoread
set noswapfile
set autochdir
set noerrorbells
set sessionoptions=help,blank,buffers,options,folds,resize,winpos,winsize
set completeopt=menuone,longest
autocmd BufEnter * if &ft =~ "python\\|tex\\|autohotkey" | set completeopt=menuone,longest,preview | else | set completeopt=menuone,longest | endif
autocmd FileType * if &ft =~ "python\\|tex\\|autohotkey" | set completeopt=menuone,longest,preview | else | set completeopt=menuone,longest | endif
set vb t_vb=
autocmd GUIEnter * set vb t_vb=
set textwidth=80
set suffixes=.bak,~,.o,.info,.swp,.obj,.pdb,.asm,.class,.pyc,.pyo,.lst,.s90,.r90,.gcno,.aux,.bbl,.blg,.glg,.glo,.gls,.ist,.out,.toc,.xdv
"排版设置
autocmd FileType * setl formatoptions=roqnlmM1
set formatoptions=roqnlmM1

function! FormatLineORSelection(sel)
    let ai = &autoindent
    let ci = &cindent
    let si = &smartindent
    set noautoindent
    set nocindent
    set nosmartindent
    if a:sel
        exe "normal gvgq"
    else
        exe "normal gqq"
    endif
    let &autoindent = ai
    let &cindent = ci
    let &smartindent = si
endfunction

nnoremap <silent> <leader>F :call FormatLineORSelection(0)<CR>
vnoremap <silent> <leader>F :<C-U>call FormatLineORSelection(1)<CR>

set complete=.,w,b,u,t

set matchpairs=(:),[:],{:},<:>
set history=1000

" 总是显示状态行
set laststatus=2
" 在编辑过程中，在右下角显示光标位置的状态行
set ruler
" 保存全局变量
set viminfo+=/100,:100,@100,c
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
if has('mouse')
    set mouse=a
endif

"右键弹出菜单
set mousemodel=popup
set selection=old
"set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=aoOtTI
" 在被分割的窗口间显示空白，便于阅读
"set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号

"set guioptions-=m "To Remove menubar 不显示菜单栏
set guioptions-=T  "To  Remove toolbar   不显示工具栏
set guioptions+=r "Uncomment this line to Remove v_scroll bar 不显示右侧的滚动条
set guioptions-=R
set guioptions-=l "no left scroll bar
set guioptions+=L
set guioptions+=c
set guioptions-=bh "no button scroll bar


set sidescroll=20
set listchars+=precedes:<,extends:>,tab:>~,trail:-,eol:<,nbsp:%

"alt键不用于菜单
set winaltkeys=no

set incsearch
set hlsearch

set expandtab

set diffopt=filler,vertical

autocmd FileType make,tags setl noexpandtab
set foldmethod=indent

" -------------------------------

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif


"tagbar setting
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_left = 1
let g:tagbar_width = 55
let g:tagbar_expand = 0
if g:isWin
    let g:tagbar_systemenc = 'cp936'
else
    let g:tagbar_systemenc = 'utf-8'
endif
let g:tagbar_sort = 0


"Voom
let g:voom_tree_width = 55
let g:voom_tree_placement = "left"
let g:voom_ft_modes = {'tex': 'latex', 'python': 'python', 'html' : 'html', 'xml' : 'html', 'pandoc' : 'pandoc', 'markdown' : 'markdown', 'org' : 'org'}

nnoremap <silent> ,o :TagbarToggle<CR>
nnoremap <silent> ,O :VoomToggle<CR>

"CScope
if has("cscope")
    set cscopequickfix=s-,d-,c-,i-,t-,e-,f-
    set csto=1
    set cst
    set nocsverb
endif

"映射
"在insert模式下移动光标
"ALT-H
inoremap è <LEFT>
"ALT-J
inoremap ê <DOWN>
"ALT-K
inoremap ë  <UP>
"ALT-L
inoremap ì <RIGHT>
"ALT-N
inoremap î  <C-RIGHT>
"ALT-P
inoremap ð <C-LEFT>
"ALT-E
inoremap å  <END>
"ALT-B
inoremap â  <HOME>
"ALT-O 直接插入空行并编辑
inoremap ï  <C-O>o

inoremap <silent> <C-L> <DEL>
inoremap <silent> <C-K> <C-W>

nnoremap ó DA
"save file
nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
vnoremap <silent> <C-S> <ESC>:update<CR>gv

noremap <silent> <F4> :q<CR>
noremap <silent> ,q :q<CR>
noremap <silent> <C-F4> :qall!<CR>
noremap <silent> <S-F4> :q!<CR>

noremap <silent> ,nb :bNext<CR>

noremap <silent> <leader>x :% !xxd -g 1<CR>
noremap <silent> <leader>X :% !xxd -g 1 -r<CR>

nnoremap <silent> ,/ :let @/=""<CR>

nnoremap <silent> ,b :BufExplorer<CR>
"打开NERDTree并且定位到当前文件
function! CallNERDTree()
    let temp = @/
    let temp2 = "\\V\\.\\*\\(-\\| \\)\\+" . expand("%") . "*\\?"
    silent edit .
    normal gg
    let @/ = temp2
    silent! normal n
    let @/ = temp
endfunction
nnoremap <silent> ,dd :call CallNERDTree()<CR>

function! QuickFixWindowToggle()
    let g:my_has_quickfix = 0
    if &buftype == 'quickfix'
        let g:my_has_quickfix = 1
        wincmd W
    else
        call Windo("if &buftype == 'quickfix' | let g:my_has_quickfix = 1 | endif")
    endif
    if g:my_has_quickfix
        execute "cclose"
    else
        execute "copen 15"
        wincmd p
    endif
endfunction
nnoremap <silent> <F3> :call QuickFixWindowToggle()<CR>

nnoremap <silent> <F7> :silent make<CR>
nnoremap <silent> ,mk :silent make<CR>

nnoremap <silent> <C-F7> :MakeThisFile<CR>
function! MakeInput()
    let ret = input("Input make arguments: ")
    exe 'silent make ' . ret
endfunction
nnoremap <silent> <S-F7> :call MakeInput()<CR>

nnoremap <silent> <F6> :UpdateTags<CR>

nnoremap <silent> <F5> :Run<CR>
nnoremap <silent> <C-F5> :e %<CR>
nnoremap <silent> <S-F5> :redraw!<CR>

nnoremap <silent> <F12> :SearchProject<CR>
nnoremap <silent> <C-F12> :EditProject<CR>
nnoremap <silent> <S-F12> :SelectHistProject<CR>
nnoremap <silent> <M-F12> :LoadSessionFile<CR>
nnoremap <silent> <F11>   :InvertWarning<CR>
nnoremap <silent> <C-F11> :LoadMakeResult<CR>
nnoremap <silent> <S-F11> :LoadGrepResult<CR>
nnoremap <silent> <M-F11> :EditFileListFile<CR>

if g:isWin
    noremap <silent> ,t :python import subprocess as sb; sb.Popen("start Console.exe", shell=1)<CR>
else
    noremap <silent> ,t :python import subprocess as sb; sb.Popen("gnome-terminal")<CR>
endif
nnoremap <silent> ,T :StartTerminal<CR>

noremap <silent> ,r :e $vimrc<CR>
noremap <silent> ,R :so $vimrc<CR>

noremap <silent> ,w :update<CR>
noremap <silent> ,W :update!<CR>

nnoremap <silent> <leader>f :py FormatCode(0)<CR>
vnoremap <silent> <leader>f :py FormatCode(1)<CR>
nnoremap <silent> <leader>j :Dox<CR>
nnoremap <silent> <leader>l :DoxLic<CR>

"bufdo and windo
function! Bufdo(cmd)
    let need_mark = (&buftype != "nofile" && &buftype != "quickfix")
    if need_mark
        let pos = getpos(".")
        normal H
        normal mX
        let b:my_buff_magic = "magic"
    endif
    exe "bufdo " . a:cmd
    if need_mark
        if !exists("b:my_buff_magic") || b:my_buff_magic != "magic"
            silent! normal `X
        endif
        normal zt
        call setpos(".", pos)
        let b:my_buff_magic = ""
    endif
endfunction

function! Windo(cmd)
    let w:my_magic_number = "magic"
    let pos = getpos(".")
    exe "windo " . a:cmd
    wincmd t
    while !exists("w:my_magic_number") || w:my_magic_number != "magic"
        wincmd w
    endwhile
    call setpos(".", pos)
    let w:my_magic_number = ""
endfunction

"switch wrap mode
if !exists("g:my_wrap_mode") | let g:my_wrap_mode = &wrap | endif
nnoremap <silent> ,a :let &wrap=!&wrap<CR>
autocmd BufWinEnter * let &wrap=g:my_wrap_mode

function! SwitchWrapMode()
    let g:my_wrap_mode = !g:my_wrap_mode
    if &buftype == "quickfix"
        wincmd W
    endif
    call Windo("let &wrap=g:my_wrap_mode")
endfunction
nnoremap <silent> ,A :call SwitchWrapMode()<CR>


"switch list mode
if !exists("g:my_list_mode") | let g:my_list_mode = &list | endif
nnoremap <silent> ,s :let &list=!&list<CR>
autocmd BufWinEnter * let &list=g:my_list_mode

function! SwitchListMode()
    let g:my_list_mode = !g:my_list_mode
    if &buftype == "quickfix"
        wincmd W
    endif
    call Windo("let &list=g:my_list_mode")
endfunction
nnoremap <silent> ,S :call SwitchListMode()<CR>


"查找选中文本
vnoremap <silent> * "yy:let @/="\\V" . substitute(@y, "\\\\", "\\\\\\\\", "g")<CR>:set hls<CR>

"替换功能
function! MyReplace(from)
    let cancelret = "THEUSEHAVECANCELEDINPUT$*%^&*^&()&)*)(*_&*(*)^"
    let dest = inputdialog("replace \"" . a:from . "\" to: ", "", cancelret)
    if dest == cancelret
        return
    endif
    let slashs = ["/", "'", "+", "-", "?", "#", "$", "!", "&", "(", ")", "~"]
    let index = 0
    while stridx(a:from, slashs[index]) >= 0
        let index = index + 1
        if index >= len(slashs)
            return
        endif
    endwhile
    let slash = slashs[index]
    execute "%s" . slash . a:from . slash . dest . slash. "gc"
endfunction

function! MyReplaceCurrentWord()
    let word = expand("<cword>")
    call MyReplace("\\V\\C\\<" . word . "\\>")
endfunction
"替换光标下的单词
nnoremap <silent> <leader>rw :call MyReplaceCurrentWord()<CR>

function! MyReplaceInput()
    let s = input("Input partten: ")
    if s != ""
        call MyReplace(s)
    endif
endfunction

nnoremap <silent> <leader>rp :call MyReplaceInput()<CR>

"find count of the word under the cursor
nnoremap <silent> ,ct :%s/\<<C-R>=expand("<cword>")<CR>\>//n<CR>

function! GetVisual() range
    let reg_save = getreg('"')
    let regtype_save = getregtype('"')
    let cb_save = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', reg_save, regtype_save)
    let &clipboard = cb_save
    return selection
endfunction

function! MyReplaceSelection()
    let word = GetVisual()
    call MyReplace("\\V\\C" . substitute(word, "\\\\", "\\\\\\\\", "g"))
endfunction
"替换选中的文本
vnoremap <silent> <leader>rp :call MyReplaceSelection()<CR>

"Cscope 的映射
"set cscopetag
nnoremap <silent> ,,s :silent cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> ,,g :silent cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> ,,c :silent cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> ,,e :silent cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> ,,d :silent cs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> ,,i :silent cs find i <C-R>=expand("%")<CR><CR>
nnoremap <silent> ,,t :silent cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> ,,f :silent cs find f <C-R>=expand("<cfile>")<CR><CR>

function! CScopeFind(type)
    let cmd = "silent cs find " . a:type . " "
    let symbol = input(cmd . ":")
    if symbol != ""
        execute cmd . symbol
    endif
endfunction

nnoremap <silent> ,,S :call CScopeFind("s")<CR>
nnoremap <silent> ,,G :call CScopeFind("g")<CR>
nnoremap <silent> ,,C :call CScopeFind("c")<CR>
nnoremap <silent> ,,E :call CScopeFind("e")<CR>
nnoremap <silent> ,,D :call CScopeFind("d")<CR>
nnoremap <silent> ,,I :call CScopeFind("i")<CR>
nnoremap <silent> ,,T :call CScopeFind("t")<CR>
nnoremap <silent> ,,F :call CScopeFind("f")<CR>


"在窗口间移动
let C_Ctrl_j='off' "关闭c.vim中的CTRL-J映射
nnoremap <silent> <C-H> <C-W>h
nnoremap <silent> <C-J> <C-W>j
nnoremap <silent> <C-K> <C-W>k
nnoremap <silent> <C-L> <C-W>l
nnoremap <silent> <M-UP> <C-W>+
nnoremap <silent> <M-DOWN> <C-W>-
nnoremap <silent> <M-LEFT> <C-W><
nnoremap <silent> <M-RIGHT> <C-W>>


"上下移动行
nnoremap <silent> <C-UP>  mz:m-2<cr>`z==
nnoremap <silent> <C-DOWN>  mz:m+<cr>`z==
xnoremap <silent> <C-UP>  :m'<-2<cr>gv=gv
xnoremap <silent> <C-DOWN>  :m'>+<cr>gv=gv


"补全
inoremap <silent> <M-/> <C-X><C-U>
inoremap <silent> <C-SPACE> <C-X><C-O>
"autocmd FileType python inoremap <buffer> . .<C-X><C-O>

"复制，选择，剪切和粘贴
nnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p
nnoremap <silent> <leader>Y "+Y
nnoremap <silent> <leader>P "+P
vnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>p "+p
vnoremap <silent> <leader>Y "+Y
vnoremap <silent> <leader>P "+P
vnoremap <silent> <C-C> "+y
vnoremap <silent> <C-X> "+d

noremap <silent> <C-A> <ESC>gg<S-V>G

inoremap <silent> <C-BS> <C-W>
cmap <C-BS> <C-W>

cmap <c-y> <Plug>CmdlineCompleteBackward
cmap <c-e> <Plug>CmdlineCompleteForward
cmap <C-P> <Up>
cmap <C-N> <Down>

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
inoremap <silent> <C-A> <C-O>gg<C-O><S-V>G
cmap <C-V> <C-R>+
nnoremap <C-V> "+gP

function! HelpThisWord()
    exe 'help ' . expand('<cword>')
endfunction

function! HelpSelection()
    let selection = GetVisual()
    exe 'help ' . selection
endfunction

nnoremap <silent> <F1> :call HelpThisWord()<CR>
vnoremap <silent> <F1> :call HelpSelection()<CR>

"CTRL-F1,F2,F3分别复制文件目录，文件名，文件路径
if g:isWin
    nnoremap <silent> <C-F1> :let @+ = substitute(expand("%:p:h"), "/", "\\", "g")<CR>
    nnoremap <silent> <C-F2> :let @+ = substitute(expand("%:p:t"), "/", "\\", "g")<CR>
    nnoremap <silent> <C-F3> :let @+ = substitute(expand("%:p"), "/", "\\", "g")<CR>
else
    nnoremap <silent> <C-F1> :let @+ = expand("%:p:h")<CR>
    nnoremap <silent> <C-F2> :let @+ = expand("%:p:t")<CR>
    nnoremap <silent> <C-F3> :let @+ = expand("%:p")<CR>
endif

function! MaxWinAndSplit()
    set lines=999 columns=999
    wincmd =
endfunction

function! RestoreWinAndSplit()
    set lines=45 columns=130
endfunction

function! OnDiffMode()
    set wrap
    let g:my_wrap_mode = 1
    set list
    let g:my_list_mode = 1
endfunction

function! OnInit()
    if &diff
        wincmd =
        set colorcolumn=
    else
        set colorcolumn=81
    endif
endfunction

if &diff
    set lines=999 columns=999
endif
autocmd VIMEnter * call OnInit()
autocmd FilterWritePost * if &diff | call OnDiffMode() | endif
nnoremap <silent> ,,wm :call MaxWinAndSplit()<CR>
nnoremap <silent> ,,wn :call RestoreWinAndSplit()<CR>

"Diff
function! DiffFiles()
    if &diff == 0
        let g:my_diff_win_count = 0
        call Windo('if &buftype == "" | let g:my_diff_win_count += 1 | endif')
        if g:my_diff_win_count <= 1
            exe "diffthis"
            exe "vert sbNext"
            exe "diffthis"
        else
            call Windo('if &buftype == "" | diffthis | endif')
        endif
        call OnDiffMode()
    else
        exe "diffoff!"
    endif
endfunction
nnoremap <silent> ,df :call DiffFiles()<CR>

nnoremap <silent> ,dv :SvnDiff<CR>
nnoremap <silent> ,dr :SvnDiffPrev<CR>
nnoremap <silent> ,du :diffupdate<CR>

function! DiffSwitchIwhite()
    if stridx(&diffopt, "iwhite") != -1
        set diffopt-=iwhite
    else
        set diffopt+=iwhite
    endif
endfunction
nnoremap <silent> ,di :call DiffSwitchIwhite()<CR>

"clear space at the end of line
function! ClearSpaceAtEOL()
    normal mx
    execute "silent! %s/\\v(\\s|\\r)+$//g"
    normal `x
endfunction
nnoremap <silent> <leader>rs :call ClearSpaceAtEOL()<CR>

"greps
function! GrepThisWord()
    let word = expand('<cword>')
    if word != ''
        if &encoding != &termencoding
            let word = iconv(word, &encoding, &termencoding)
        endif
        exe 'silent grep \b' . expand('<cword>') . '\b'
    endif
endfunction

function! GrepPattern()
    let pattern = input('grep: ')
    if pattern != ''
        if &encoding != &termencoding
            let pattern = iconv(pattern, &encoding, &termencoding)
        endif
        exe 'silent grep ' . pattern
    endif
endfunction
nnoremap <silent> ,gw :call GrepThisWord()<CR>
nnoremap <silent> ,gp :call GrepPattern()<CR>
python << PYEOF
def to_re_pattern(s):
    ss = []
    for c in s:
        if c in r"\[]{}().*?+":
            ss.append("\\")
            ss.append(c)
        elif c == "\n":
            ss.append('\\n')
        else:
            ss.append(c)
    return ''.join(ss)

def grep_selection():
    selection = vim.eval("GetVisual()")
    if not selection:
        return
    if vim.eval('&encoding') != vim.eval('&termencoding'):
        selection = selection.decode(vim.eval('&encoding')).encode(vim.eval('&termencoding'), 'replace')
    vim.command('silent grep %s' % to_re_pattern(selection))

def replace_to(pattern):
    ret = vim.eval('input("Input replacement: ")')
    do = vim.eval('''input('Do you want to replace "%s" to "%s"?(y/n)')''' % (pattern, ret))
    if do and do.lower() in ['y', 'yes']:
        replace_pattern(pattern, ret)

def replace_input():
    pattern = vim.eval('input("Input pattern: ")')
    if not pattern:
        return
    replace_to(pattern)

def replace_this_word():
    word = vim.eval('expand("<cword>")')
    if not word:
        return
    replace_to("".join(["\\b", word, "\\b"]))

def replace_selection():
    sel = vim.eval('GetVisual()')
    replace_to(to_re_pattern(sel))

def find_related_file():
    ext = vim.eval('expand("%:e")')
    if not ext:
        return
    if ext.lower() in ['c', 'cpp', 'cxx', 'cc']:
        exts = ['h', 'hpp', 'hxx', 'hh']
    elif ext.lower() in ['h', 'hpp', 'hxx', 'hh']:
        exts = ['c', 'cpp', 'cxx', 'cc']
    else:
        return
    for ext in exts:
        fname = vim.eval('expand("%:r")') + '.' + ext
        ret = vim.eval('findfile("%s")' % fname)
        if ret:
            vim.command('silent edit %s' % ret)
            break

PYEOF
vnoremap <silent> ,gp :python grep_selection()<CR>
nnoremap <silent> <leader>Rw :python replace_this_word()<CR>
nnoremap <silent> <leader>Rp :python replace_input()<CR>
vnoremap <silent> <leader>Rp :python replace_selection()<CR>

nnoremap <silent> ,I :python find_related_file()<CR>

"自动提示
let g:acp_enableAtStartup = 0
let g:acp_mappingDriven = 1

"关于DoxygenToolkit的设置
let g:DoxygenToolkit_versionString = "1.0"
let g:DoxygenToolkit_authorName = "Hulei"
let g:DoxygenToolkit_licenseTag = "Copyright (C) " . strftime("%Y") . " Feitian Technologies Co., Ltd. All rights reserved."


autocmd FileType ruby,eruby setl omnifunc=rubycomplete#Complete
autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setl omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setl omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
autocmd FileType java setl omnifunc=javacomplete#Complete


nnoremap <silent> <C-N> :silent cn<CR>
nnoremap <silent> <C-P> :silent cp<CR>

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:echofunc_close=1
let g:fencview_autodetect = 0
let g:indent_guides_guide_size = 1

"tex setting
let g:tex_comment_nospell = 1
let g:tex_conceal=""

let NERDTreeShowLineNumbers=1

"echo func settings
let g:EchoFuncKeyNext='<M-.>'
let g:EchoFuncKeyPrev='<M-,>'
let g:EchoFuncAutoStartBalloonDeclaration=0

"python syntax
let g:python_highlight_all=1
let g:python_version_2=1

"delimitMate settings
let delimitMate_matchpairs = "(:),[:],{:}"
autocmd FileType xml,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
"autocmd FileType tex let b:delimitMate_quotes = ""
let delimitMate_autoclose = 1
let delimitMate_balance_matchpairs = 1
let delimitMate_expand_cr = 1
set backspace=indent,eol,start

"Align settings
let g:Align_xstrlen=3

let loaded_snips=1

"xptemplate
let g:xptemplate_key = "<Tab>"
let g:xptemplate_brace_complete = 0
let g:xptemplate_highlight = 'following,next'
"in python file do not map ' and "
"autocmd FileType python,vimproj silent! inoremap <buffer> <silent> ' '| silent! inoremap <buffer> <silent> " "
"
"
"clang
function! InsertTab()
    let line = getline(".")
    let start = col(".")
    if start > 0
        let start -= 1
    endif
    let line = strpart(line, start)
    if (match(line, "<#[^#]*#>") != -1)
        return "\<Esc>\<Tab>"
    else
        "for xptemplate
        return "\<C-R>=XPTemplateStart(0,{'k':'<Tab++'})\<CR>"
        "return '\<Tab>'
    endif
endfunction
autocmd FileType c,cpp imap <buffer><silent><expr> <Tab> InsertTab()
let g:clang_auto_select=2
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_preiodic_quickfix=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_complete_macros=1
let g:clang_trailing_placeholder=1
let g:clang_make_default_keymappings = 1
let g:clang_use_library=1
if g:isWin
let g:clang_library_path=$VIMRUNTIME
else
let g:clang_library_path= '/usr/lib/llvm-3.4/lib'
endif
let g:clang_user_options='-I' . join(split($CPLUS_INCLUDE_PATH, ';'), ' -I')

"airline
let g:airline#extensions#tagbar#enabled = 0


" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

python << EOF
def save_colorscheme():
    if int(vim.eval("g:isGUI")):
        with open(vim.eval("$HOME") + "/.colorscheme", "wb") as f:
            f.write("colorscheme " + vim.eval("g:colors_name") + "\n" + "set background=" + vim.eval("&background"))

if int(vim.eval("g:isGUI")):
    if os.path.isfile(vim.eval("$HOME") + "/.colorscheme"):
        vim.command("so $HOME/.colorscheme")
    else:
        vim.command("colorscheme molokai")
        vim.command("set background=dark")

EOF

autocmd ColorScheme * python save_colorscheme()

if !g:isGUI
    let g:indentLine_loaded = 1
    let g:autohighlight_loaded = 1
endif

"close autohighlight
let g:autohighlight_loaded = 1

" for pandoc-syntax, do not hidden text
let g:pandoc#syntax#conceal#use = 0
au FileType pandoc set nospell


" mark.vim settings
nmap <silent> ,mm <Plug>MarkSet
vmap <silent> ,mm <Plug>MarkSet
nmap <silent> ,mr <Plug>MarkRegex
vmap <silent> ,mr <Plug>MarkRegex
nmap <silent> ,mc <Plug>MarkClear
nmap <silent> ,mn <Plug>MarkClear

" related file
nnoremap <silent> ,i  :OpenRelatedFile<CR>
let g:relatedfile_user_dict = {".md" : [".html"], ".html" : [".md"]}

" map relativenumber switch
nnoremap <silent> ,rn :let &relativenumber = !&relativenumber<CR>

" autohotkey dict
autocmd FileType autohotkey setl omnifunc=ahkcomplete#Complete

" pandoc
autocmd FileType pandoc setl iskeyword=@,48-57,_,128-167,224-235
