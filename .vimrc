" neobundle
let g:make = 'gmake'
if system('uname -a') == 'GNU/Linux'
	let g:make = 'make'
endif
set rtp+=~/.vim/bundle/neobundle.vim/
let s:bootstrap = 0
try
	call neobundle#rc()
catch /E117:/
	let s:bootstrap = 1
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
	redraw!
	call neobundle#rc()
endtry
NeoBundleFetch 'Shougo/neobundle'
" requires vimproc.vim
NeoBundle 'eagletmt/ghcmod-vim'
" requires neocomplete.vim
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': g:make}}
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-tbone'
if s:bootstrap
	NeoBundleInstall
end
filetype plugin indent on

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
map <F1> <Esc>
imap <F1> <Esc>
let mapleader=","

" filetype definitions
autocmd BufRead,BufNewFile *.slim	setfiletype slim
autocmd BufRead,BufNewFile *.coffee	setfiletype coffee

" filetype settings
autocmd FileType *	set sts=0 sw=8 noet tw=0 nocin si
autocmd FileType cabal	set sts=2 sw=2 et nocin si
autocmd FileType coffee	set sts=2 sw=2 et
autocmd FileType eruby	set sts=2 sw=2 et
autocmd FileType gitcommit	set tw=68 et nosi
autocmd FileType haskell	set sts=2 sw=2 et
autocmd FileType html	set sts=4 sw=4 et
autocmd FileType java	set sts=4 sw=4 et cin nosi
autocmd FileType javascript	set sts=2 sw=2 et cin nosi
autocmd FileType mail	set sts=4 sw=4 et nosi tw=68
autocmd FileType markdown	set sts=2 sw=2 et tw=68
autocmd FileType perl	set sts=4 sw=4 et
autocmd FileType python	set sts=4 sw=4 et
autocmd FileType ruby	set sts=2 sw=2 et
autocmd FileType rst	set sts=2 sw=2 et tw=68
autocmd FileType scss	set sts=2 sw=2 et
autocmd FileType slim	set sts=2 sw=2 et
autocmd FileType sql	set sts=4 sw=4 et
autocmd FileType tex	set sts=4 sw=4 et tw=68
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
hi PmenuSel ctermbg=magenta ctermfg=black

" other highlighting
hi Folded ctermfg=green ctermbg=none

" Unite
call unite#set_profile('source/file', 'ignorecase', 1)
call unite#set_profile('source/file_rec', 'ignorecase', 1)
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)
let g:unite_source_rec_max_cache_files = 99999
nnoremap <Leader>t :Unite -start-insert file_rec<Enter>

" completion
let g:neocomplete#enable_at_startup = 1

" ghcmod-vim
nnoremap <F2> :GhcModType<Enter>
nnoremap <silent> <F3> :GhcModTypeClear<Enter>
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
