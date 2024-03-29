" neobundle
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif
set rtp+=~/.vim/bundle/neobundle.vim/
let s:bootstrap = 0
try
	call neobundle#begin(expand('~/.vim/bundle/'))
catch /E117:/
	let s:bootstrap = 1
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
	redraw!
	call neobundle#begin(expand('~/.vim/bundle/'))
endtry
NeoBundleFetch 'Shougo/neobundle.vim'
" requires vimproc.vim
NeoBundle 'eagletmt/ghcmod-vim'
if has('lua')
  " requires neocomplete.vim
  NeoBundle 'eagletmt/neco-ghc'
  NeoBundle 'Shougo/neocomplete.vim'
endif
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': g:make}}
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-tbone'
NeoBundle 'nkpart/slide-madness'
NeoBundle 'idris-hackers/idris-vim'
if s:bootstrap
	NeoBundleInstall
end
call neobundle#end()
filetype plugin indent on

" swap file
set dir=/var/tmp
set noswapfile

" ui
set mouse=""
set t_Co=8
set ruler
set laststatus=2
set showmode
set nohlsearch
set cursorline
set listchars=tab:‣\ ,trail:␣
set list
set noincsearch
set noshowcmd

" general settings
set nomodeline
set nowrap
set number
set cinoptions=(s
set formatoptions+=ro
set backspace=indent,eol,start
inoremap # X#
map <F1> <Esc>
imap <F1> <Esc>
let mapleader=","

" filesystem settings
set nobackup
set noundofile

" filetype definitions
autocmd BufRead,BufNewFile *.slim	setfiletype slim
autocmd BufRead,BufNewFile *.coffee	setfiletype coffee
autocmd BufRead,BufNewFile,BufFilePre *.md set filetype=markdown

" filetype settings
autocmd FileType *	set sts=0 sw=8 noet tw=0 nocin si
autocmd FileType cabal	set sts=2 sw=2 et nocin si
autocmd FileType coffee	set sts=2 sw=2 et
autocmd FileType eruby	set sts=2 sw=2 et
autocmd FileType gitcommit	set tw=68 et nosi
autocmd FileType haskell	set sts=2 sw=2 et
autocmd FileType chaskell	set sts=2 sw=2 et
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
autocmd FileType smarty	set sts=2 sw=2 et  " *.tpl
autocmd FileType sql	set sts=4 sw=4 et
autocmd FileType tex	set sts=4 sw=4 et tw=68
autocmd FileType vim	set sts=2 sw=2 et
autocmd FileType yaml	set sts=2 sw=2 et

autocmd BufReadPost COMMIT_EDITMSG :0

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
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)
let g:unite_source_rec_max_cache_files = 99999
nnoremap <Leader>t :Unite -start-insert -ignorecase file_rec<Enter>

" completion
let g:neocomplete#enable_at_startup = 1

" ghcmod-vim
silent !which ghc-mod >/dev/null 2>&1
redraw!
if !v:shell_error
	nnoremap <F2> :GhcModType<Enter>
	nnoremap <silent> <F3> :GhcModTypeClear<Enter>
	autocmd BufWritePost *.hs GhcModCheckAndLintAsync
endif
