hi link Parens Special
syn match Parens /[\[\]{}();]/

exe 'so '. escape(expand('<sfile>:p:h'), '\') . '/doxygen.vim'
