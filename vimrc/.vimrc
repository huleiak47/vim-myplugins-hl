set nocompatible
filetype off

let g:isWin = (has("win32") || has("win64") || has("win32unix"))
let g:isGUI = has("gui_running")
let g:isWSL = filereadable('/mnt/c/Windows/System32/notepad.exe')
let $vimrc = $HOME . "/.vimrc"

" vundle plugins
execute 'set rtp+=' . $HOME . '/.vimplugins/Vundle'
call vundle#rc($HOME . '/.vimplugins')


"first time use git clone https://github.com/gmarik/vundle.git  ~/.vimplugins/vundle to get vundle
"
" Plugins
Plugin 'gmarik/Vundle'

Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'morhetz/gruvbox'
Plugin 'huleiak47/vim-myplugins-hl'
Plugin 'xptemplate'
Plugin 'dominikduda/vim_current_word'

if &diff == 0
Plugin 'huleiak47/vim-RelatedFile'
Plugin 'junegunn/vim-easy-align'
Plugin 'scrooloose/nerdcommenter'
Plugin 'netrw.vim'
Plugin 'CmdlineComplete'
Plugin 'DoxygenToolkit.vim'
Plugin 'inkarkat/vim-ingo-library'
Plugin 'inkarkat/vim-mark'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'
Plugin 'huleiak47/vim-AHKcomplete'
Plugin 'altercation/vim-colors-solarized'
Plugin 'w0rp/ale'
Plugin 'sbdchd/neoformat'
Plugin 'Yggdroot/LeaderF'
Plugin 'aklt/plantuml-syntax'
Plugin 'pboettch/vim-cmake-syntax'
Plugin 'cespare/vim-toml'
Plugin 'luochen1990/rainbow'
Plugin 'gabrielelana/vim-markdown'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'ferrine/md-img-paste.vim'
Plugin 'elzr/vim-json'
Plugin 'gyim/vim-boxdraw'
Plugin 'dstein64/vim-startuptime'

Plugin 'huleiak47/vim-SimpleIDE'
Plugin 'Tagbar'
if !g:isWSL
Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'huleiak47/vim-cmake-complete'
endif

" --------------------------------------------------------

let mapleader = "'"

syntax on

filetype on
filetype plugin on
filetype indent on

"==================================================================
"通用的配置
autocmd FileType dosbatch setl fileformat=dos | setl fenc=gbk
if g:isWin
    "set shellslash
    set fencs=ucs-bom,utf-8,gbk,big5,latin-1
    if &fenc == "" && &modifiable
        set fenc=utf-8
    endif
    "set fileformats=dos,unix
    set fileformats=unix,dos
    if g:isGUI
        set encoding=utf-8
        set ambiwidth=double
        set guifont=Sarasa_Mono_SC:h9.5
        set guifontwide=Sarasa_Mono_SC:h9.5
        set linespace=1
        set cursorline "高亮当前行
        language messages en_US.utf-8
    else
        language messages en_US.utf-8
        set encoding=utf-8
        colorscheme neon
        set nocursorline
    endif
    set termencoding=gbk
else
    "set guifont=DejaVu\ Sans\ Mono\ 9
    "set guifontwide=WenQuanYi\ Zen\ Hei\ 12
    "set guifontwide=文泉驿等宽微米黑\ 10
    set guifont=Sarasa\ Term\ SC\ 10
    set guifontwide=Sarasa\ Term\ SC\ 10
    set linespace=0
    set fencs=ascii,ucs-bom,utf-8,gb18030,big5,latin-1,utf-16
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

if g:isGUI && !exists("s:has_inited")
    let s:has_inited = 1
    set lines=40 columns=160
endif

if g:isGUI && g:isWin
    set renderoptions=type:directx,level:0.75,gamma:2.0,contrast:0.25,geom:1,renmode:5,taamode:1
endif

set textwidth=120
set hidden
set fdl=99
set numberwidth=5
set number
set norelativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType cmake setl tabstop=2 | setl softtabstop=2 | setl shiftwidth=2
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
set completeopt=menuone,longest,preview
set colorcolumn=121

set vb t_vb=
autocmd GUIEnter * set vb t_vb=
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

nnoremap <silent> ,F :call FormatLineORSelection(0)<CR>
vnoremap <silent> ,F :<C-U>call FormatLineORSelection(1)<CR>

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

set guioptions-=m "To Remove menubar 不显示菜单栏
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

set diffopt+=internal,indent-heuristic,algorithm:histogram

autocmd FileType make,tags setl noexpandtab
set foldmethod=indent
set winfixheight

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


" YouCompleteMe settings
autocmd FileType c,cpp,python,java nnoremap <buffer> ,gf :YcmCompleter GoToDefinition<CR>
autocmd FileType c,cpp,python,java nnoremap <buffer> ,gc :YcmCompleter GoToDeclaration<CR>
autocmd FileType c,cpp,python,java nnoremap <buffer> ,gt :YcmCompleter GoTo<CR>
autocmd FileType python,java nnoremap <buffer> <C-]> :YcmCompleter GoTo<CR>
autocmd FileType c,cpp,python,cs,javascript,rust,go,java nnoremap <buffer> ,gc :YcmCompleter GoToReferences<CR>
autocmd FileType c,cpp,python,cs,javascript,rust,go,java nnoremap <buffer> ,yc :YcmCompleter
autocmd FileType c,cpp,python,cs,javascript,rust,go,java nnoremap <buffer> ,yd :YcmDiags<CR>
autocmd FileType c,cpp,python,cs,javascript,rust,go,java nnoremap <buffer> ,yf :YcmCompleter FixIt<CR>
let g:ycm_add_preview_to_completeopt=1
let g:ycm_complete_in_comments = 0
let g:ycm_complete_in_strings = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_disable_for_files_larger_than_kb = 10000
let g:ycm_global_ycm_extra_conf = $HOME . '/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
if g:isGUI
    let g:ycm_error_symbol = '❌'
    let g:ycm_warning_symbol = '✋'
else
    let g:ycm_error_symbol = 'E'
    let g:ycm_warning_symbol = 'W'
endif
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_max_diagnostics_to_display = 0
if g:isWin
    let g:ycm_python_binary_path = 'python.exe'
    let g:ycm_server_python_interpreter = 'python.exe'
endif
let g:ycm_semantic_triggers = {
    \ 'c,cpp,python,java,cs,javascript': ['re!\w{2}'],
    \}

let g:ycm_filetype_blacklist = {
        \ 'tagbar': 1,
        \ 'notes': 1,
        \ 'markdown': 1,
        \ 'netrw': 1,
        \ 'unite': 1,
        \ 'text': 1,
        \ 'vimwiki': 1,
        \ 'pandoc': 1,
        \ 'infolog': 1,
        \ 'mail': 1
        \}
" ycm end

"tagbar setting
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_left = 1
let g:tagbar_width = 45
let g:tagbar_expand = 0
let g:tagbar_show_linenumbers = -1
if g:isWin
    let g:tagbar_systemenc = 'cp936'
else
    let g:tagbar_systemenc = 'utf-8'
endif
let g:tagbar_sort = 0


nnoremap <silent> ,ot :TagbarToggle<CR>
nnoremap <silent> <F2> :TagbarToggle<CR>

"CScope
if has("cscope")
    set cscopequickfix=s-,d-,c-,i-,t-,e-,f-,g-
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

"ALT-S 删除当前光标及之后的文本，并进入insert模式
nnoremap ó DA
"save file
nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
vnoremap <silent> <C-S> <ESC>:update<CR>gv

noremap <silent> <F4> :q<CR>
noremap <silent> <C-F4> :qall!<CR>
noremap <silent> <S-F4> :q!<CR>

nnoremap <silent> ,rl :e %<CR>
nnoremap <silent> ,rd :redraw!<CR>

noremap <silent> ,bn :bnext<CR>
noremap <silent> ,bp :bprevious<CR>

noremap <silent> ,xx :% !xxd -g 1<CR>
noremap <silent> ,xr :% !xxd -g 1 -r<CR>

nnoremap <silent> ,/ :let @/=""<CR>

nnoremap <silent> ,bb :BufExplorer<CR>

"nnoremap <silent> <Space> <C-W>W

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

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent> <S-F2> :VimFilerExplorer -winwidth=45<CR><C-W>l

function! QuickFixWindowToggle()
    if len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"'))
        execute "cclose"
    else
        execute "botright copen 15"
        wincmd p
    endif
endfunction
nnoremap <silent> <F3> :call QuickFixWindowToggle()<CR>
nnoremap <silent> ,qf :call QuickFixWindowToggle()<CR>

nnoremap <silent> <F7> :VPMakeProject<CR>
nnoremap <silent> ,pmk :VPMakeProject<CR>
nnoremap <silent> <C-F7> :VPRebuildProject<CR>
nnoremap <silent> ,prb :VPRebuildProject<CR>

function! MakeProjectArgs()
    let pattern = input('VPMakeProject ')
    if pattern != ''
        if &encoding != &termencoding
            let pattern = iconv(pattern, &encoding, &termencoding)
        endif
        exe 'VPMakeProject ' . pattern
    endif
endfunction
nnoremap <silent> <S-F7> :call MakeProjectArgs()<CR>
nnoremap <silent> ,pma :call MakeProjectArgs()<CR>

nnoremap <silent> <F6> :VPUpdateTags<CR>
nnoremap <silent> ,pup :VPUpdateTags<CR>

nnoremap <silent> <F5> :VPRunExecution<CR>
nnoremap <silent> ,pex :VPRunExecution<CR>

nnoremap <silent> <C-F12> :VPEditProject<CR>
nnoremap <silent> ,pep :VPEditProject<CR>
nnoremap <silent> <S-F12> :VPSelectHistProject<CR>
nnoremap <silent> ,php :VPSelectHistProject<CR>
nnoremap <silent> <M-F12> :VPLoadSessionFile<CR>
nnoremap <silent> ,pls :VPLoadSessionFile<CR>
nnoremap <silent> <F11>   :VPInvertWarning<CR>
nnoremap <silent> ,piw   :VPInvertWarning<CR>
nnoremap <silent> <C-F11> :VPLoadMakeResult<CR>
nnoremap <silent> ,plm :VPLoadMakeResult<CR>
nnoremap <silent> <S-F11> :VPLoadGrepResult<CR>
nnoremap <silent> ,plg :VPLoadGrepResult<CR>
nnoremap <silent> <M-F11> :VPEditFileListFile<CR>
nnoremap <silent> ,pel :VPEditFileListFile<CR>
nnoremap <silent> ,pt :VPStartTerminal<CR>

if g:isWin
python3 << PYTHON_CMD
import subprocess as sp
import platform
def open_console():
    if int(platform.win32_ver()[0]) >= 10:
        sp.Popen("start cmd.exe /c cmdex.exe", shell=1) # cmd.exe for Win10 is good enought
    else:
        sp.Popen("start Console.exe -t cmdex", shell=1)

PYTHON_CMD
    noremap <silent> ,tt :py3 open_console()<CR>
else
    noremap <silent> ,tt :term<CR>
endif

noremap <silent> ,rc :e $vimrc<CR>
noremap <silent> ,rC :so $vimrc<CR>

noremap <silent> ,w :update<CR>

" neoformat
nnoremap <silent> ,fm :Neoformat<CR>
vnoremap <silent> ,fm :Neoformat &ft<CR>
" neoformat python
"
let g:neoformat_c_astyle = {
            \ 'exe': 'astyle',
            \ 'args': [],
            \ 'stdin': 1,
            \ }

let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-style=file'],
            \ 'stdin': 1,
            \}
let g:neoformat_cpp_astyle = g:neoformat_c_astyle
let g:neoformat_java_astyle = g:neoformat_c_astyle
let g:neoformat_cs_astyle = g:neoformat_c_astyle

let g:neoformat_cpp_clangformat = g:neoformat_c_clangformat
let g:neoformat_java_clangformat = g:neoformat_c_clangformat

let g:neoformat_enabled_c = ['clangformat', 'astyle']
let g:neoformat_enabled_cpp = ['clangformat', 'astyle']
let g:neoformat_enabled_java = ['clangformat', 'astyle']
let g:neoformat_enabled_cs = ['clangformat', 'astyle']

let g:neoformat_tex_latexindent = {
        \ 'exe': 'latexindent',
        \ 'args': ['-w', "--local=" . $HOME . "/latexindentSettings.yaml"],
        \ 'stdin': 0,
        \ 'replace': 1
        \}

let g:neoformat_enabled_markdown = ['mdformat']
let g:neoformat_markdown_mdformat = {
        \ 'exe': 'cmd.exe',
        \ 'args': ['/c', 'mdformat.py'],
        \ 'stdin': 1,
        \}


" doxygen
nnoremap <silent> ,dx :Dox<CR>
nnoremap <silent> ,doxl :DoxLic<CR>

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
nnoremap <silent> ,ap :let &wrap=!&wrap<CR>
autocmd BufWinEnter * let &wrap=g:my_wrap_mode

function! SwitchWrapMode()
    let g:my_wrap_mode = !g:my_wrap_mode
    if &buftype == "quickfix"
        wincmd W
    endif
    call Windo("let &wrap=g:my_wrap_mode")
endfunction
nnoremap <silent> ,aa :call SwitchWrapMode()<CR>


"switch list mode
if !exists("g:my_list_mode") | let g:my_list_mode = &list | endif
nnoremap <silent> ,ss :let &list=!&list<CR>
autocmd BufWinEnter * let &list=g:my_list_mode

function! SwitchListMode()
    let g:my_list_mode = !g:my_list_mode
    if &buftype == "quickfix"
        wincmd W
    endif
    call Windo("let &list=g:my_list_mode")
endfunction
nnoremap <silent> ,sa :call SwitchListMode()<CR>


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
nnoremap <silent> ,rw :call MyReplaceCurrentWord()<CR>
nnoremap <silent> <M-w> :call MyReplaceCurrentWord()<CR>

function! MyReplaceInput()
    let s = input("Input partten: ")
    if s != ""
        call MyReplace(s)
    endif
endfunction

nnoremap <silent> ,rp :call MyReplaceInput()<CR>
nnoremap <silent> <M-r> :call MyReplaceInput()<CR>

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
vnoremap <silent> ,rp :call MyReplaceSelection()<CR>
vnoremap <silent> <M-r> :call MyReplaceSelection()<CR>

"Cscope 的映射
"set cscopetag
function! CScopeFindWord(type)
    if a:type == "i"
        let word = expand("%")
    else
        let word = expand("<cword>")
    endif
    if word != ""
        execute "copen 15"
        wincmd p
        execute "silent cs find " . a:type . " " . word
    endif
endfunction

nnoremap <silent> ,,s :call CScopeFindWord("s")<CR>
nnoremap <silent> ,,g :call CScopeFindWord("g")<CR>
nnoremap <silent> ,,c :call CScopeFindWord("c")<CR>
nnoremap <silent> ,,e :call CScopeFindWord("e")<CR>
nnoremap <silent> ,,d :call CScopeFindWord("d")<CR>
nnoremap <silent> ,,i :call CScopeFindWord("i")<CR>
nnoremap <silent> ,,t :call CScopeFindWord("t")<CR>
nnoremap <silent> ,,f :call CScopeFindWord("f")<CR>

function! CScopeFind(type)
    let cmd = "silent cs find " . a:type . " "
    let symbol = input(cmd . ":")
    if symbol != ""
        execute "copen 15"
        wincmd p
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
"let C_Ctrl_j='off' "关闭c.vim中的CTRL-J映射
"nnoremap <silent> <C-H> <C-W>h
"nnoremap <silent> <C-J> <C-W>j
"nnoremap <silent> <C-K> <C-W>k
"nnoremap <silent> <C-L> <C-W>l
"nnoremap <silent> <M-UP> <C-W>+
"nnoremap <silent> <M-DOWN> <C-W>-
"nnoremap <silent> <M-LEFT> <C-W><
"nnoremap <silent> <M-RIGHT> <C-W>>

"上下移动行
nnoremap <silent> <C-UP>  mz:m-2<cr>`z==
nnoremap <silent> <C-DOWN>  mz:m+<cr>`z==
xnoremap <silent> <C-UP>  :m'<-2<cr>gv=gv
xnoremap <silent> <C-DOWN>  :m'>+<cr>gv=gv


"补全
inoremap <silent> <M-/> <C-X><C-O>
inoremap <silent> <C-SPACE> <C-X><C-O>
inoremap <silent> <C-F> <C-X><C-F>

"复制，选择，剪切和粘贴
nnoremap <silent> ,yy "+Y`]
nnoremap <silent> ,pp "+p`]
nnoremap <silent> ,PP "+P`]
vnoremap <silent> ,yy "+y`]
vnoremap <silent> <C-c> "+y`]
vnoremap <silent> ,pp "+p`]
vnoremap <silent> <C-v> "+p`]
vnoremap <silent> ,xx "+d`]
vnoremap <silent> <C-x> "+d`]
"inoremap <script> <C-v> <C-o>"+P
exe 'inoremap <script> <C-v>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-v>' paste#paste_cmd['v']

inoremap <silent> <C-a> <C-O>gg<C-O><S-V>G
vnoremap <silent> <C-a> <ESC>gg<S-V>G
nnoremap <silent> <C-a> <ESC>gg<S-V>G
cmap <C-v> <C-R>+

" WSL clipboard
if g:isWSL
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    func! WriteToClipboard(reg)
        call system('echo -n '.shellescape(getreg(a:reg)).' | '.s:clip)
    endfunc

    func! GetClipboard()
        return trim(system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard'))
    endfunc

    vnoremap <silent> ,yy y:call WriteToClipboard('0')<CR>
    vnoremap <silent> <C-c> y:call WriteToClipboard('0')<CR>
    nnoremap <silent> ,yy Y:call WriteToClipboard('0')<CR>

    nnoremap <silent> ,pp :r !/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard<CR>
    vnoremap <silent> ,pp xh:r !/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard<CR>
    vnoremap <silent> <C-v> xh:r !/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard<CR>
    vnoremap <silent> ,xx x:call WriteToClipboard('"')<CR>
    vnoremap <silent> <C-x> x:call WriteToClipboard('"')<CR>
    inoremap <silent> <C-v> <ESC>:r !/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard<CR>i

    cmap <C-v> <C-r>=GetClipboard()<CR>
endif

" 使用 ppppp 进行多行多次粘贴操作
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" 通过 12<Space> 跳转到第 12 行
" 按 <Space> 跳到行文件末尾。
" 按 <Backspace> 回到文件开始。
"nnoremap <Space> G
nnoremap <BS> gg

inoremap <silent> <C-BS> <C-W>
cmap <C-BS> <C-W>

cmap <c-y> <Plug>CmdlineCompleteBackward
cmap <c-e> <Plug>CmdlineCompleteForward
cmap <C-P> <Up>
cmap <C-N> <Down>

function! HelpThisWord()
    exe 'help ' . expand('<cword>')
endfunction

function! HelpSelection()
    let selection = GetVisual()
    exe 'help ' . selection
endfunction

nnoremap <silent> <F1> :call HelpThisWord()<CR>
vnoremap <silent> <F1> :call HelpSelection()<CR>

"分别复制文件目录，文件名，文件路径
if g:isWin
    nnoremap <silent> ,yd :let @+ = substitute(expand("%:p:h"), "/", "\\", "g")<CR>
    nnoremap <silent> ,yn :let @+ = substitute(expand("%:p:t"), "/", "\\", "g")<CR>
    nnoremap <silent> ,yp :let @+ = substitute(expand("%:p"), "/", "\\", "g")<CR>
else
    nnoremap <silent> ,yd :let @+ = expand("%:p:h")<CR>
    nnoremap <silent> ,yn :let @+ = expand("%:p:t")<CR>
    nnoremap <silent> ,yp :let @+ = expand("%:p")<CR>
endif

function! OnDiffMode()
    set wrap
    let g:my_wrap_mode = 1
    set list
    let g:my_list_mode = 1
endfunction

autocmd GUIEnter * if &diff | simalt ~x | endif
autocmd FilterWritePost * if &diff | call OnDiffMode() | endif

"Diff
function! DiffFiles()
    if &diff == 0
        let g:my_diff_win_count = 0
        call Windo('if &buftype == "" | let g:my_diff_win_count += 1 | endif')
        if g:my_diff_win_count <= 1
            exe "diffthis"
            exe "vert sbnext"
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
nnoremap <silent> ,dg :TagbarClose<CR>:Gdiff<CR>
nnoremap <silent> ,du :diffupdate<CR>

function! DiffSwitchIwhite()
    if stridx(&diffopt, "iwhite") != -1
        set diffopt-=iwhite
        set diffopt-=iblank
    else
        set diffopt+=iwhite
        set diffopt+=iblank
    endif
endfunction
nnoremap <silent> ,di :call DiffSwitchIwhite()<CR>

function! DiffSwitchAlgo()
    if stridx(&diffopt, "algorithm:histogram") != -1
        set diffopt-=algorithm:histogram
        set diffopt+=algorithm:myers
    else
        set diffopt-=algorithm:myers
        set diffopt+=algorithm:histogram
    endif
endfunction
nnoremap <silent> ,da :call DiffSwitchAlgo()<CR>

"clear space at the end of line
function! ClearSpaceAtEOL()
    normal mx
    execute "silent! %s/\\v(\\s|\\r)+$//g"
    normal `x
endfunction
nnoremap <silent> ,rs :call ClearSpaceAtEOL()<CR>

nnoremap <silent> ,pgw :VPGrepThisWord<CR>
nnoremap <silent> <M-*> :VPGrepThisWord<CR>
nnoremap <silent> ,pgp :VPGrepInput<CR>
nnoremap <silent> <M-F> :VPGrepInput<CR>
vnoremap <silent> ,pgp :<C-U>VPGrepSelection<CR>
vnoremap <silent> <M-F> :<C-U>VPGrepSelection<CR>
nnoremap <silent> ,prw :VPReplaceThisWord<CR>
nnoremap <silent> <M-W> :VPReplaceThisWord<CR>
nnoremap <silent> ,prp :VPReplaceInput<CR>
nnoremap <silent> <M-R> :VPReplaceInput<CR>
vnoremap <silent> ,prp :VPReplaceSelection<CR>
vnoremap <silent> <M-R> :VPReplaceSelection<CR>

"自动提示
let g:acp_enableAtStartup = 0
let g:acp_mappingDriven = 1

"doxygen
let g:doxygen_enhanced_color = 1
autocmd FileType c,cpp,java,php exe 'setl syntax=' . &filetype . '.doxygen'

"关于DoxygenToolkit的设置
let g:DoxygenToolkit_versionString = "1.0"
let g:DoxygenToolkit_authorName = "Hulei"
let g:DoxygenToolkit_licenseTag = "Copyright (c) " . strftime("%Y") . ", Nations Technologies Inc. All rights reserved."
let g:DoxygenToolkit_maxFunctionProtoLines = 30


autocmd FileType ruby,eruby setl omnifunc=rubycomplete#Complete
autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setl omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setl omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
"autocmd FileType python,java setl omnifunc=youcompleteme#CompleteFunc


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

" NERDTree setting
let NERDTreeShowLineNumbers=1
let NERDTreeWinSize=45

"python syntax
let g:python_highlight_all=1
let g:python_version_2=0

"delimitMate settings
let delimitMate_matchpairs = "(:),[:],{:},（:）"
autocmd FileType xml,html let b:delimitMate_matchpairs = "(:),[:],{:},（:）"
autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
"autocmd FileType tex let b:delimitMate_quotes = ""
let delimitMate_autoclose = 1
let delimitMate_balance_matchpairs = 1
let delimitMate_expand_cr = 1
set backspace=indent,eol,start

"Align settings
let g:Align_xstrlen=3

let loaded_snips=1

" map = to align =
vnoremap = :EasyAlign =<CR>

"xptemplate
let g:xptemplate_brace_complete = 0
let g:xptemplate_highlight = 'following,next'
"in python file do not map ' and "
"autocmd FileType python,vimproj silent! inoremap <buffer> <silent> ' '| silent! inoremap <buffer> <silent> " "

"airline
let g:airline#extensions#tagbar#enabled = 0
"let g:airline_theme = &background
let g:airline#extensions#ycm#enabled = 1
"let g:airline#extensions#ycm#error_symbol = 'E:'
"let g:airline#extensions#ycm#warning_symbol = 'W:'

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
nnoremap <silent> ,fi  :OpenRelatedFile<CR>
let g:relatedfile_user_dict = {".md" : [".html"], ".html" : [".md"]}

" map relativenumber switch
nnoremap <silent> ,rn :let &relativenumber = !&relativenumber<CR>

" autohotkey dict
autocmd FileType autohotkey setl omnifunc=ahkcomplete#Complete

" pandoc
autocmd FileType pandoc setl iskeyword=@,48-57,_,128-167,224-235

set suffixes=.bak,~,.o,.info,.swp,.tmp,.obj,.pdb,.class,.pyc,.pyo,.pyd,.lst,.s90,.r90,.gcno,.aux,.bbl,.blg,.glg,.glo,.gls,.ist,.out,.toc,.xdv,.lib,.a,.suo,.sdf,.bin,.exe,.dll,.sbr,.cap,.dblite,.zip,.rar,.7z,.tar,.gz,.jar,.ilk,.exp,.so

"LeaderF
let g:Lf_RootMarkers = ['.leaderfignore', '.git', '.hg', '.svn', '.vprj', '.vscode', '.project']
let g:Lf_WorkingDirectoryMode = 'AF'
let g:Lf_ShortcutF = ',ff'
let g:Lf_ShortcutB = ',fb'
let g:Lf_UseVersionControlTool = 0
let g:Lf_DefaultExternalTool = ""
let g:Lf_PreviewCode = 0
let g:Lf_FollowLinks = 1
let g:Lf_WindowPosition = 'top'

nnoremap <M-f> :LeaderfFile<CR>
nnoremap <M-b> :LeaderfBuffer<CR>
nnoremap B :LeaderfBuffer<CR>
nnoremap <M-l> :LeaderfLine<CR>
nnoremap ,fl :LeaderfLine<CR>
nnoremap <M-L> :LeaderfLineAll<CR>
nnoremap <M-o> :LeaderfBufTag<CR>
nnoremap ,fo :LeaderfBufTag<CR>
nnoremap <M-O> :LeaderfTag<CR>
nnoremap ,ft :LeaderfTag<CR>
nnoremap <M-u> :LeaderfFunction<CR>
nnoremap ,fu :LeaderfFunction<CR>

" jts file
au BufReadPost *.jts setf pascal
au BufCreate *.jts setf pascal
let g:pascal_delphi = 1

" ale
let g:ale_linters = {
\   'python': ['flake8'],
\   'vim': [],
\   'c': [],
\   'cpp': [],
\   'java': [],
\   'tex': [],
\   'markdown': [],
\}

if g:isGUI
    let g:ale_sign_error = '❌'
    let g:ale_sign_warning = '✋'
else
    let g:ale_sign_error = 'E'
    let g:ale_sign_warning = 'W'
endif

" markdown for tagbar
" create a markdown.ctags file in ~/.ctags.d/ and write text below into the file:
" --langdef=md
" --langmap=md:.md
" --regex-md=/^(#+[ \t]+.*)/\1/h,Headings/ 
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'md',
    \ 'kinds'     : [
        \ 'h:Headings',
    \ ],
    \ 'sort'    : 0,
\ }

" comment selection
vmap / <leader>cs
" uncomment selection
vmap ? <leader>c<space>

" switch comment status
nmap ? <leader>c<space>

" nerd commenter
let g:NERDCustomDelimiters = {
    \ 'apdu': { 'left': '//'},
    \ 'vimproj': { 'left': '#'},
    \ 'autohotkey': { 'left': ';'},
    \ 'dosbatch': {'left': '::', 'leftAlt': 'REM'},
\ }

" rainbow
let g:rainbow_active = 1

" vim-markdown
let g:markdown_enable_spell_checking = 0
if &diff == 0
    autocmd FileType markdown syntax clear markdownTableHeader | syntax clear markdownUrlLinkInText | syntax clear markdownTableDelimiter
endif

" gruvbox do not invert color in selection mode
let g:gruvbox_invert_selection = 0

function! ShowInPreview(lines)
    let l:command = "silent! pedit! +setlocal\\ " .
                  \ "buftype=nofile\\ nobuflisted\\ " .
                  \ "noswapfile\\ nonumber\\ " .
                  \ "filetype=" . " " . "Preview"

    exe l:command

    if has('nvim')
        let l:bufNr = bufnr(a:name)
        call nvim_buf_set_lines(l:bufNr, 0, -1, 0, a:lines)
    else
        call setbufline("Preview", 1, a:lines)
    endif
endfunction

" md-img-paste
nmap ,pi :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = '_images'

python3 << PYTHON_CMD
import re
def change_font_size(is_inc):
    step = 0.5
    max_size = 50
    min_size = 2
    guifont = vim.eval("&guifont")
    guifontwide = vim.eval("&guifontwide")
    mobj1 = re.match("^(.*?)(\d+(?:.\d+)?)$", guifont)
    mobj2 = re.match("^(.*?)(\d+(?:.\d+)?)$", guifontwide)
    if not mobj1 or not mobj2:
        return
    font1 = mobj1.group(1)
    font2 = mobj2.group(1)
    size1 = float(mobj1.group(2))
    size2 = float(mobj2.group(2))
    new_size1, new_size2 = ((size + step) if is_inc else (size - step) for size in (size1, size2))
    if not (min_size <= new_size1 <= max_size and min_size <= new_size2 <= max_size):
        return
    vim.command("set guifont=%s%s" % (font1, new_size1))
    vim.command("set guifontwide=%s%s" % (font2, new_size2))

PYTHON_CMD
nnoremap <C-PageUp> :py3 change_font_size(is_inc=True)<CR>
nnoremap <C-PageDown> :py3 change_font_size(is_inc=False)<CR>

" settings for vim_current word
let g:vim_current_word#highlight_delay = 300
let g:vim_current_word#highlight_only_in_focused_window = 0
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 1
function! SetCurrentWord()
    if &bg == "dark"
        hi CurrentWordTwins guifg=NONE guibg=#006060 gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
        hi CurrentWord      guifg=NONE guibg=#600060 gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
    else
        hi CurrentWordTwins guifg=NONE guibg=#C0F0F0 gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
        hi CurrentWord      guifg=NONE guibg=#F0C0F0 gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
    endif
endfunction
autocmd ColorScheme * call SetCurrentWord()

" load some extra initialization code
let $extra_init = $HOME . "/.vimplugins/vim-myplugins-hl/vimrc/extra_init.vim"
source $extra_init
