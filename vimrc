" enable all vim features
set nocompatible
" enable filetype detection as well as type-specific plugin/indentation
filetype plugin indent on

syntax on " syntax highlight

""" word wrap
set wrap " wrap long lines
setlocal wrap
au VimEnter * if &diff | execute 'windo set wrap' | endif

set diffopt+=iwhite       " ignore whitespaces
set diffopt+=foldcolumn:0 " don't show extra column for folds
set diffopt+=context:12   " show this many lines around diffs

set number
set relativenumber
set mouse=a   " enable mouse usage (all modes)
set ttyfast " speed up scrolling in Vim

set hlsearch   " highlight the search terms
set incsearch  " jump to the matches while typing
set ignorecase " ignore case for searches
set smartcase  " case sensitive when using capitals in search phrase

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'chrisbra/vim-diff-enhanced'
Plug 'joeytwiddle/vim-diff-traffic-lights-colors'
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
set background=dark

