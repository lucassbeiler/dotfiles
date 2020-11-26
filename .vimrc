## curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

syntax on
set number
set nocompatible
set smartindent
set autoindent
set smartcase
set showmode
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set nowrap
set nobackup
set noswapfile
set undodir=~/.vim/undodir
set undofile
set incsearch
set encoding=UTF-8
set smartcase
set completeopt=noinsert,menuone,noselect

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd vimenter * NERDTree
autocmd! VimEnter * NERDTree | wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <C-o> <ESC>:NERDTreeToggle<CR>

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'jremmen/vim-ripgrep'
Plug 'kien/ctrlp.vim'
Plug 'AlessandroYorba/Alduin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'chrisbra/colorizer'
call plug#end()


if &term =~ '256color'
    set t_ut=
endif
let g:colorizer_auto_color = 1
colorscheme alduin
set background=dark
