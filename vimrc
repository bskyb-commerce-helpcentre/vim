" ~/.vimrc
" vim:set ft=vim et tw=78 sw=2:

let mapleader = ","

" Section: Options {{{1
" ---------------------
if has("win32")
  let &runtimepath = substitute(&runtimepath,'\(Documents and Settings[\\/][^\\/]*\)[\\/]\zsvimfiles\>','.vim','g')
endif

silent! call pathogen#runtime_append_all_bundles()

set nocompatible
set autoindent
set autowrite       " Automatically save before commands like :next and :make
set backspace=2
set backupskip+=*.tmp,crontab.*

filetype plugin indent on

if has("balloon_eval") && has("unix")
  set ballooneval
endif

set showbreak=↳\ 

set cmdheight=2
set complete-=i     " Searching includes can be slow
set display=lastline

set incsearch       " Incremental search
set joinspaces
set laststatus=2    " Always show status line
set number          " Show line numbers

"set lazyredraw

set listchars=tab:>\ ,trail:-
set listchars+=extends:>,precedes:<
if version >= 700
  set listchars+=nbsp:+
endif

set modelines=5      " Debian likes to disable this
set scrolloff=5      " minimum number of lines above and below the cursor
set showcmd          " Show (partial) command in status line.
set showmatch        " Show matching brackets.
set smartcase        " Case insensitive searches become sensitive with capitals
set smarttab         " sw at the start of the line, sts everywhere else
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set softtabstop=2
set splitbelow       " Split windows at bottom

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}*%=%-16(\ %l,%c-%v\ %)%P

set tags+=../tags,../../tags,../../../tags,../../../../tags
set timeoutlen=1200 " A little bit more time for macros
set ttimeoutlen=50  " Make Esc work faster

set visualbell " Instead of beeping when doing something wrong
set virtualedit=block
set wildmenu
set wildmode=longest,list
set wildignore=.git,downloader,pkginfo,includes,tmp
set winaltkeys=no

if !has("gui_running") && $DISPLAY == '' || !has("gui")
  set mouse=
endif

" Section: Mappings {{{1
" ----------------------

map \\ <Plug>NERDCommenterInvert
map <Leader>v  :so ~/.vimrc<CR>

" Section: Visual
" ---------------
syntax enable

" Set control and e expand zencoding
let g:user_zen_expandabbr_key = '<c-e>'

" Set json filestype to javascript for syntax check
autocmd BufNewFile,BufRead *.json   set ft=javascript
autocmd BufNewFile,BufRead *.coffee set ft=coffee
autocmd FileType           html   setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType           php    setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Use ~/tmp/ for swp and backup dir
set backupdir=/tmp
set directory=/tmp

" case insensitive search
set ignorecase
set smartcase

"Better line wrapping 
set nowrap
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

" ---------------------------------------------------------------------------
"  Strip all trailing whitespace in file
" ---------------------------------------------------------------------------
function! StripWhitespace ()
  exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

function! CorrectTestRunner()
  if match(expand('%'), '\.feature$') != -1
    return "cucumber"
  elseif match(expand('%'), '_spec\.rb$') != -1
    return "rspec"
  else
    return "ruby"
  endif
endfunction

map <Leader>t :call RunCurrentTest()<CR>
inoremap jj <ESC>
