" ~/.vimrc
" vim:set ft=vim et tw=78 sw=2:

let mapleader = ","

" Section: Options {{{1
" ---------------------
silent! call pathogen#runtime_append_all_bundles()

set nocompatible
set autoindent
set autowrite       " Automatically save before commands like :next and :make
set backspace=2
set backupskip+=*.tmp,crontab.*

filetype plugin indent on

set showbreak=↳\ 

set cmdheight=2
set complete-=i     " Searching includes can be slow
set display=lastline

set incsearch       " Incremental search
set joinspaces
set laststatus=2    " Always show status line
set number          " Show line numbers

if has("mac")
  silent! set nomacatsui
else
  set lazyredraw
endif

set listchars=tab:>\ ,trail:-
set listchars+=extends:>,precedes:<
set listchars+=nbsp:+

set modelines=5      " Debian likes to disable this
set scrolloff=5      " minimum number of lines above and below the cursor
set showcmd          " Show (partial) command in status line.
set showmatch        " Show matching brackets.
set smartcase        " Case insensitive searches become sensitive with capitals
set expandtab
set smarttab         " sw at the start of the line, sts everywhere else
set shiftwidth=2
set softtabstop=2
set tabstop=2

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}*%=%-16(\ %l,%c-%v\ %)%P

set tags+=../tags,../../tags,../../../tags,../../../../tags
set timeoutlen=1200 " A little bit more time for macros
set ttimeoutlen=50  " Make Esc work faster

set visualbell " Instead of beeping when doing something wrong
set virtualedit=block
set wildmenu
set wildmode=longest:full,full
set wildignore=.git,downloader,pkginfo,includes,tmp

if !has("gui_running") && $DISPLAY == '' || !has("gui")
  set mouse=
endif

" Section: Mappings {{{1
" ----------------------

map \\ <Plug>NERDCommenterInvert
map <Leader>v  :so ~/.vimrc<CR>

" Section: Visual
" ---------------

colorscheme vividchalk

" Switch syntax highlighting on, when the terminal has colors
if exists("&guifont")
  if has("mac")
    set guifont=Monaco:h12
  elseif has("unix")
    if &guifont == ""
      set guifont=Monaco\ 11
    endif
  elseif has("win32")
    set guifont=Consolas:h11,Courier\ New:h10
  endif
endif

syntax on

" Set control and e expand zencoding
let g:user_zen_expandabbr_key = '<c-e>'

" Set json filestype to javascript for syntax check
autocmd BufNewFile,BufRead *.json set      ft=javascript

" Use /tmp/ for swp and backup dir
"set backupdir=/Users/jamie/.tmp
"set directory=/Users/jamie/.tmp

" case insensitive search
set ignorecase
set smartcase

"Better line wrapping 
set wrap
set textwidth=79
set formatoptions=qrn1

"Enable code folding
set nofoldenable

silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>

"Enabling Zencoding
let g:user_zen_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \  'erb' : {
  \    'extends' : 'html',
  \  },
 \}

let g:CommandTMaxDepth = 20
let g:CommandTMaxHeight = 8

" Remove toolbar
setglobal guioptions-=T
setglobal guioptions-=r
setglobal guioptions-=L

set completeopt+=longest,menu,preview

inoremap jj <ESC>

" vim-rspec plugin

" disable default key binding
let g:RspecKeymap=0
map <Leader>r :RunSpec<CR>
map <Leader>rl :RunSpecLine<cr>

" Highlight lines longer than 80 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
