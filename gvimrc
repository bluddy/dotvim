call pathogen#infect()
call pathogen#helptags()

set nocompatible " vim rather than vi settings

" allow backspacing over everything
set backspace=indent,eol,start

" 4 space indent
set shiftwidth=4

" 4 stops
set tabstop=4

set autoindent

" Don't save a backup
set nobackup
set nowritebackup

" 50 lines of command line history
set history=100

" incremental search
set incsearch

" Set ignorecase on
set ignorecase
set smartcase

" Highlight searched things
set hlsearch

" Incremental search
set incsearch

" Syntax highlighting
syntax on
filetype plugin indent on
set mouse=a

set cursorline
set ruler

" Line numbers
set nu

" Show matching brackets
set showmatch

" Wrap all keys including backspace
set whichwrap=b,s,h,l,<,>,[,]

set background=light
colorscheme solarized

set clipboard=unnamed

" Prevent breaking up of lines
set textwidth=0 wrapmargin=0

" Visual wrapping enabled
set wrap

" Map jk to esc
inoremap jk <Esc>
" Map x so it doesn't record (we don't need single characters in registers)
nnoremap x "_x
nnoremap X "_X
nnoremap Y y$
" Replace W with w when trying to save but not when followed/preceded by any
" other letter
cnoreabbrev W w

" Replace j with gj and k with gk: walking up and down virtual lines
" vmap <D-j> gj
" vmap <D-k> gk
" vmap <D-4> g$
" vmap <D-6> g^
" vmap <D-0> g^
" nmap <D-j> gj
" nmap <D-k> gk
" nmap <D-4> g$
" nmap <D-6> g^
" nmap <D-0> g^

" Haskell options
au FileType haskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 smarttab shiftround nojoinspaces

" For latex
let g:tex_flavor='latex' " Get vim to label the file properly
" Grep sometimes doesn't display a filename
set grepprg=grep\ -nH\ $*

" For Alternate extension. Allow switching between interface and source ocaml
" files
let g:alternateExtensions_ML="mli"

if has("autocmd")
	" Allow .. instead of :edit %:h when browsing in fugitive (git) trees
	autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif
	" Don't flood open buffers with fugitive files
	autocmd BufReadPost fugitive://* set bufhidden=delete
endif



