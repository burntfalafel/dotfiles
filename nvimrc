" Main options {{{
filetype plugin indent on
filetype plugin on
filetype indent on
syntax on

" Interface settings {{{
"## 256 terminal
"let g:solarized_termcolors=256
"let g:solarized_diffmode="high"
set background=dark
"https://github.com/thedenisnikulin/vim-cyberpunk
set termguicolors
colorscheme cyberpunk

"set term=tmux-256color
"## More options
set ruler
set wildmenu
"set hidden  " Useful feature, to have multiples buffer open
"cursor
set cursorline
"hi clear CursorLine 
"hi CursorLine term=bold cterm=bold guibg=Grey40
"tabs into spaces
set expandtab
"Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
match Error /{{{\|}}}/
" }}}
set clipboard=unnamedplus
set number
" General settings {{{
set noswapfile
set nobackup
set nowritebackup

" Waiting times are painful
"set timeoutlen=500
"set ttimeoutlen=5

"Correct broken redraw
set ttyfast
set noerrorbells
set novisualbell
set t_vb=
set lazyredraw

"Indentation
set shiftwidth=2
set expandtab
set tabstop=2
set backspace=2
set foldmethod=marker
set cino=N-s

"uncategorized
"set exrc
set wildignore=*.so,*.sw,*.pyc
set mouse=a

" }}}

"Key-binding {{{
" ---------------------------------------------------------------------
let mapleader = ","

nnoremap Q <Nop>

" Tabs
map <silent> <F2> :tabprevious<Enter>
map <silent> <F3> :tabnext<Enter>
map <silent> <F4> :tabnew<Enter>
map <silent> <F9> :NERDTreeToggle<Enter>
map <silent> <F8> :TagbarToggle<Enter>

"Customized shortcuts
nnoremap <silent> <leader>k :next<CR>
nnoremap <silent> <leader>j :previous<CR>
nnoremap <silent> <leader>q :q<cr>
nnoremap <silent> <leader>w :w!<cr>
nnoremap <silent> <leader>e :Gstatus<CR>
nnoremap <silent> <leader>E :bd .git/index<CR>
nnoremap <silent> <leader>a :copen<CR>
nnoremap <silent> <leader>A :cclose<CR>
nnoremap <silent> <leader>d :Gdiff<CR>
nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap <leader><space> :noh<cr>
"Replace
"https://vi.stackexchange.com/questions/13689/how-to-find-and-replace-in-vim-without-having-to-type-the-original-word
"Put the cursor on the word u want to change and hit leader+r followed by the
"string u want to replace with.
nnoremap <leader>r :,$s/\<<C-r><C-w>\>//gc\|1,''-&&<left><left><left><left><left><left><left><left><left><left><left>
noremap <C-J> <C-W><C-J>
noremap <C-H> <C-W><C-H>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-]> <C-W><C-S>
noremap <C-\> <C-W><C-V>
noremap <C-Q> <C-W><C-Q>
"nnoremap <leader>. :CtrlPTag<CR>
" Ctrl + t for going up tag stack
"nnoremap <leader>[ :tp<CR>
"nnoremap <leader>] :tn<CR>
"nnoremap <silent> # <C-z>
" Spelling
" https://vi.stackexchange.com/questions/68/autocorrect-spelling-mistakes
" Go back to last misspelled word and pick first suggestion.
autocmd FileType markdown,vimwiki inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u

" Select last misspelled word (typing will edit).
autocmd FileType markdown,vimwiki noremap <C-J> <Esc>[sve<C-G>
autocmd FileType markdown,vimwiki noremap <C-J> <Esc>[sve<C-G>
autocmd FileType markdown,vimwiki noremap <C-J> <Esc>b[sviw<C-G>

"Great map which saves the file in sudo mode, something like `sudo !!`
cnoremap w!! w !sudo tee >/dev/null %

ab W w
ab Wq wq
ab wQ wq
ab WQ wq
ab Q q
ab WQA wqa
ab Wqa wqa

" The hard way
nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>

" Switching between windows
nnoremap <C-Right>	 :vsplit 
nnoremap <C-Left>	 :Vex<CR>
nnoremap <C-Down>	 :split 
nnoremap <C-Up>		 :Sex<CR>
nnoremap <C-e>		 :E<CR>
nnoremap <Up>	     <C-w>5-
nnoremap <Down>      <C-w>5+
nnoremap <Left>      <C-w>10<
nnoremap <Right>     <C-w>10>
tnoremap <Esc>		 <C-\><C-n>
"}}}
"Plugins {{{
call plug#begin('~/usr/nvim/plugged')
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mhinz/vim-signify'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
call plug#end()
" }}}
" Vim-signify {{{
" default updatetime 4000ms is not good for async update
set updatetime=100
" }}}