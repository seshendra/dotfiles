" leader
let mapleader=","

set nocompatible                " Make Vim more useful, keep at the beginning
set clipboard=unnamed           " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set wildmenu                    " Enhance command-line completion
set backspace=indent,eol,start  " Allow backspace in insert mode
set ttyfast                     " Optimize for fast terminal connections
set gdefault                    " Add the g flag to search/replace by default
set binary
set noeol                       " Don’t add empty newlines at the end of files
set modeline                    " Respect modeline in files
set ignorecase                  " Ignore case of searches
set hlsearch                    " Highlight searches
set smartindent
set fileencoding=utf-8          " Use UTF-8 without BOM
set encoding=utf-8 nobomb
set incsearch                   " Highlight dynamically as pattern is typed
set showmatch
set relativenumber              " Show relative numbers too (hybrid mode)
set number                      " Show line numbers
set nobackup
set noswapfile
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " Show the filename in the window titlebar
set visualbell                  " do not beep
set noerrorbells
set nostartofline               " Don’t reset cursor to start of line when moving around.
syntax on                       " Enable syntax highlighting
set cursorline                  " Highlight current line
set tabstop=4                   " Make tabs as wide as two spaces
set shiftwidth=4
set expandtab
set shortmess=atI               " Don’t show the intro message when starting Vim
set ruler                       " Show the cursor position
set showmode                    " Show the current mode
set modelines=4
set t_Co=256                    " Set 256 colors

" Disable visual bell
autocmd GUIEnter * set vb t_vb= " for your GUI
autocmd VimEnter * set vb t_vb=

" enable pathogen
execute pathogen#infect()

filetype on
filetype indent on
filetype plugin on


""" SOLARIZED """
syntax enable

colorscheme solarized
let g:solarized_termcolors = &t_Co
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
set background=dark

" disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
map <C-j> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Get output of shell commands
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>"

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" Disable folding for Markdown plugin
let g:vim_markdown_folding_disabled=1

" set font
set guifont=Menlo\ Regular:h14

" open nerdree to current doc folder
autocmd BufEnter * lcd %:p:h
" compile gradle
map <F4> :w<CR> :compiler gradle<CR> :make test<CR>:cw 4<CR>
" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>


" highlight 81 chars (tip from Damian Conway)
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red

    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" Use space to jump down a page (like browsers do)...
nnoremap <Space> <PageDown>

runtime! config/**/*.vim
