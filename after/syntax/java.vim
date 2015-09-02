hi link Parens Special
syn match Parens /[\[\]{}();]/

hi link Class Type
syn match Class /\<\u\w*\l\>\|\.\zs\u\w*\l\>/

exe 'so '. escape(expand('<sfile>:p:h'), '\') . '/doxygen.vim'
