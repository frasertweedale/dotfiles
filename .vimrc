" .vimrc

" swap file
set dir=/var/tmp
set noswapfile

" ui
set ruler
set laststatus=2
set showmode
set nohlsearch
set cursorline

" general settings
set nowrap
set number
set cinoptions=(s
set formatoptions+=ro
set backspace=indent,eol,start
inoremap # X#

" filetype definitions
autocmd BufRead,BufNewFile *.slim	setfiletype slim
autocmd BufRead,BufNewFile *.coffee	setfiletype coffee

" filetype settings
autocmd FileType *	set sts=0 sw=8 noet tw=0 nocin si
autocmd FileType coffee	set sts=2 sw=2 et
autocmd FileType eruby	set sts=2 sw=2 et
autocmd FileType gitcommit	set tw=68 et nosi
autocmd FileType html	set sts=4 sw=4 et
autocmd FileType java	set sts=4 sw=4 et cin nosi
autocmd FileType javascript	set sts=2 sw=2 et cin nosi
autocmd FileType mail	set sts=4 sw=4 et nosi tw=68
autocmd FileType python	set sts=4 sw=4 et
autocmd FileType ruby	set sts=2 sw=2 et
autocmd FileType scss	set sts=2 sw=2 et
autocmd FileType slim	set sts=2 sw=2 et
autocmd FileType yaml	set sts=2 sw=2 et

" folding
set foldmethod=indent
set foldminlines=5
set foldnestmax=5

" syntax highlighting
syntax enable
hi CursorLine cterm=NONE ctermbg=DarkGrey
hi Comment ctermfg=green
hi Constant ctermfg=yellow
hi String ctermfg=darkyellow
hi Identifier ctermfg=darkcyan
hi Function ctermfg=cyan
hi Statement ctermfg=magenta
hi SpecialKey cterm=underline ctermfg=DarkGrey

" other highlighting
hi Folded ctermfg=green ctermbg=none

if version >= 702
	" trailing whitespace
	call matchadd('Underlined', '\s\+$')
	" mark tabs with dark underline
	call matchadd('SpecialKey', '\t', 0)
	" tabs anywhere but start of line, encompassing adjacent whitespace
	call matchadd('Underlined', '^\t* *[^\t]\+\zs\s*\t\+\s*')
else
	autocmd BufWinEnter * match  Underlined /[^\t]\zs\t\+\|\s\+$/
	autocmd BufWinEnter * 2match Underlined /^\t*\zs \+\ze[^* ]/
endif

" plugins
call pathogen#infect()
filetype plugin indent on
