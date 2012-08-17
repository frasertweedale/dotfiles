" .vimrc

" swap file
set dir=/var/tmp
set noswapfile

" ui
set ruler
set laststatus=2
set showmode
set nohlsearch

" general settings
set ts=4
set sw=4
set noet
set bs=indent,eol,start
set nowrap
set nu
set cino=(s
set formatoptions+=ro
set backspace=indent,eol,start
set tw=0
inoremap # X#

" really required?
"set fileformat=unix

" filetype settings
autocmd FileType *      set ts=8 sw=8 noet cin nosi
autocmd FileType python set ts=4 sw=4 et nocin si
autocmd FileType mail   set ts=4 sw=4 et nocin nosi tw=68

" folding
set foldmethod=indent
set foldminlines=5
set foldnestmax=5

" syntax highlighting
syntax enable
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
