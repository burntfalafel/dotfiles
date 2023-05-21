""" word wrap
setlocal wrap
au VimEnter * if &diff | execute 'windo set wrap' | endif

set diffopt+=iwhite       " ignore whitespaces
set diffopt+=foldcolumn:0 " don't show extra column for folds
set diffopt+=context:12   " show this many lines around diffs

set number
set relativenumber

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

