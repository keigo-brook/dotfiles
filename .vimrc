set nocompatible

" view settings

colorscheme molokai
let g:molokai_original=1
let g:rehash256=1
highlight Normal ctermbg=none
syntax on
set title
set ruler

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,utf-8,ucs-2,cp932,sjis
set number
set cursorline
set laststatus=2
set cmdheight=2
set showmatch
set helpheight=999

" cursor settings

set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set scrolloff=8
set sidescrolloff=16
set sidescroll=1

" file settings

set confirm
set hidden
set autoread
set nobackup
set noswapfile

" search/replace settings

set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

" tab/indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" other
set clipboard=unnamed,unnameplus
set mouse=a
set shellslash
" set iminsert=2

" command line settings
set wildmenu wildmode=list:longest,full
set history=1000

" beep
set visualbell t_vb=
set noerrorbells