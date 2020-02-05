" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/bin/bash
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

set modeline

set ignorecase
set smartcase

set whichwrap+=<,>,h,l
set noerrorbells
set novisualbell
set vb t_vb=
set hlsearch "highlight search matches

set display=lastline,uhex
set wildignore=.svn,CVS
set wildignore+=*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.pyc
set wildignore+=.*.swp,.*.swo
set wildignore+=*.log,*.aux,*.dvi,*.aut,*.bbl,*.blg,*.out,*.toc,*.ttt,*.snm
set wildignore+=*.fdb_latexmk,*.fls,*.lof,*.lot,*.brf,*.pdf
set wildmenu
set wildmode=full
set cmdheight=1

set nofsync
set nowrap

set tabstop=8
set expandtab
set shiftwidth=4
set smarttab autoindent

" automatically save and restore folds
set foldmethod=marker
" default fold level, all open, set it 200 or something
" to make it all closed.
set foldlevel=0
set foldcolumn=1 " width of foldcolumn
" make fillchars empty
set fillchars=fold:\ 
func! MyFoldText()
    let line = getline(v:foldstart)
    " delete comment-type chars
    let sub = substitute(line, '/\*\|\*/\|{{{\d\=\|//\|{\|\"\|#', '', 'g')
    " eat up whitespace
    let sub = substitute(sub, '^\s\+\|\s\+$', '', 'g')
    " new text for folds
    let sub = v:folddashes . v:folddashes . '{ ' . sub . ' }'
    return sub
    " fix folds we have introduced
    "}}}
endfunc
set foldtext=MyFoldText()

set complete=.,t,i,b,w,k,u
set completeopt=menuone,menu
nnoremap <silent> <C-n> :bn<CR>
" use moll/vim-bbye plugin to delete buffer but not window
nnoremap <silent> <leader>bd :Bdelete<CR>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
" equal size
nnoremap <space>= <c-W>=
nnoremap <space>o <c-W>o
command HighlightWhitespace /\s\+$
" reflow paragraph text
nnoremap Q gqap
" reflow visually selected lines
vnoremap Q gq

" make j and k more intuitive
nnoremap <silent> j gj
nnoremap <silent> k gk
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
" for x11 clipboard; TODO investigate this further
map ,y "+y
 " consider this: map jj to esc
inoremap jk <Esc>
nnoremap <silent> <leader>h :nohlsearch<CR>
" Fix email paragraphs
nnoremap <leader>par :%s/^>$//<CR>
" Swap ; and :  Convenient. But breaks some stuff like the R plugin,
" beware.
nnoremap ; :
nnoremap : ;
nnoremap <leader>w :w<CR>

cnoreabbrev Wq wq
cnoreabbrev W w
