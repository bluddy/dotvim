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

set gdefault				" regex defaults to g
set hlsearch				" Highlight searched things
set incsearch				" incremental search

" Set ignorecase on
set ignorecase
set smartcase

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
"colorscheme solarized
"let g:solarized_termcolors=256

set clipboard=unnamed

" Prevent breaking up of lines
set textwidth=0 wrapmargin=0

" Visual wrapping enabled
set wrap

" Command completion more useful
set wildmenu " Show many options
set wildmode=list:longest  " Complete up to point of ambiguity

" Show window title
set title

set visualbell		" don't beep
set noerrorbells	" don't beep

set hidden          " Allow buffers to go into the background

" Make paste mode easy
set pastetoggle=<F2>

" Map jk to esc
inoremap jk <Esc>
" Map x so it doesn't record (we don't need single characters in registers)
nnoremap x "_x
nnoremap X "_X
nnoremap Y y$
" Replace W with w when trying to save but not when followed/preceded by any
" other letter
cnoreabbrev W w

" Make going down/up long lines easier
nnoremap j gj
nnoremap k gk

" Make moving around windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader><space> :nohlsearch<CR>		" clear search with ,space

" Better leader
let mapleader = ","


" Haskell options
au FileType haskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 smarttab shiftround nojoinspaces

" For latex
let g:tex_flavor='latex' " Get vim to label the file properly
" Grep sometimes doesn't display a filename
set grepprg=grep\ -nH\ $*

" For Alternate extension. Allow switching between interface and source ocaml
" files
let g:alternateExtensions_ML="mli"
let g:LustyJugglerSuppressRubyWarning=1  " Suppress Lusty Juggler's ruby messages

if has("autocmd")
	" Allow .. instead of :edit %:h when browsing in fugitive (git) trees
	autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif
	" Don't flood open buffers with fugitive files
	autocmd BufReadPost fugitive://* set bufhidden=delete
endif

fun! EnsureVamIsOnDisk(vam_install_path)
  " windows users may want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, 7-zip and git tools first
  " -> BUG [4] (git-less installation)
  let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
  if eval(is_installed_c)
	return 1
  else
	if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
	  " I'm sorry having to add this reminder. Eventually it'll pay off.
	  call confirm("Remind yourself that most plugins ship with ".
				  \"documentation (README*, doc/*.txt). It is your ".
				  \"first source of knowledge. If you can't find ".
				  \"the info you're looking for in reasonable ".
				  \"time ask maintainers to improve documentation")
	  call mkdir(a:vam_install_path, 'p')
	  execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
	  " VAM runs helptags automatically when you install or update 
	  " plugins
	  exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
	endif
	return eval(is_installed_c)
  endif
endf

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager['key'] = value
  "     Pipe all output into a buffer which gets written to disk
  " let g:vim_addon_manager['log_to_buf'] =1

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  if !EnsureVamIsOnDisk(vam_install_path)
	echohl ErrorMsg
	echomsg "No VAM found!"
	echohl NONE
	return
  endif
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  call vam#ActivateAddons(['abolish','Gundo','ReplaceWithRegister', 'LaTeX-Suite_aka_Vim-LaTeX','LustyJuggler','snipmate-snippets','vimwiki','bufexplorer.zip','matchit.zip','Solarized','yankstack','ctrlp','The_NERD_Commenter','surround','EasyMotion','The_NERD_tree','Tabular','fugitive','repeat','taglist'], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

  " Addons are put into vam_install_path/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic

  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()
" experimental [E1]: load plugins lazily depending on filetype, See
" NOTES
" experimental [E2]: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]


