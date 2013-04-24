" swap file
set dir=/var/tmp
set noswapfile

" ui
set ruler
set laststatus=2
set showmode
set nohlsearch
set cursorline
set listchars=tab:‣\ ,trail:␣
set list

" general settings
set nowrap
set number
set cinoptions=(s
set formatoptions+=ro
set backspace=indent,eol,start
inoremap # X#
let mapleader=","

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
autocmd FileType rst	set sts=2 sw=2 et tw=68
autocmd FileType scss	set sts=2 sw=2 et
autocmd FileType slim	set sts=2 sw=2 et
autocmd FileType yaml	set sts=2 sw=2 et

" folding
set foldmethod=indent
set foldminlines=5
set foldnestmax=5
set foldignore=

" syntax highlighting
syntax enable
hi CursorLine cterm=NONE ctermbg=DarkGrey
hi Comment ctermfg=green
hi Constant ctermfg=yellow
hi String ctermfg=darkyellow
hi Identifier ctermfg=darkcyan
hi Function ctermfg=cyan
hi Statement ctermfg=magenta
hi SpecialKey ctermfg=DarkGrey
hi Error ctermbg=NONE ctermfg=red cterm=bold,underline
hi Todo ctermbg=NONE ctermfg=yellow cterm=bold,underline

" other highlighting
hi Folded ctermfg=green ctermbg=none

" plugins
silent! call pathogen#infect()
filetype plugin indent on
