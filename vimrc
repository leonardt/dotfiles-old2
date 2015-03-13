" initalization {{{
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
 if &compatible
   set nocompatible               " Be iMproved
 endif

 " Required:
 set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" }}}

" plugins {{{
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-endwise'

NeoBundle 'szw/vim-ctrlspace'
NeoBundle 'Raimondi/delimitMate'

NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'hynek/vim-python-pep8-indent'
" NeoBundle 'justinmk/vim-sneak'
NeoBundle 'hdima/python-syntax'
NeoBundle 'lokaltog/vim-easymotion'

NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'bling/vim-airline'

call neobundle#end()
filetype plugin indent on

NeoBundleCheck
" }}}

set encoding=utf-8

syntax on

let mapleader = "\<Space>"

set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set tabstop=2
set backspace=indent,eol,start
set history=1000
set undofile
set undoreload=10000

set autoindent
set smartindent
set hidden

set incsearch
set ignorecase
set smartcase

set wrap
set textwidth=80
" set number set relativenumber

set cursorline

set noshowmode

set mouse=a
set lazyredraw
set hidden
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·
set fcs=vert:│
set laststatus=2
set visualbell

" Save when losing focus
au FocusLost * :silent! wall

" Wildmenu completion {{{

set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.orig                           " Merge resolution files

" }}}

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" colorscheme {{{
let g:hybrid_use_Xresources = 1
colorscheme hybrid
" }}}

" Neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python =
\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" alternative pattern: '\h\w*\|[^. \t]\.\w*'
" }}}

" easymotion {{{
map <Leader> <Plug>(easymotion-prefix)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
" }}}

" python {{{
let python_highlight_all = 1  " python-syntax
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#show_call_signatures = 0
" }}}

" unite {{{
nnoremap <leader><Space>  :<C-u>Unite buffer<CR>
nnoremap <C-p> :<C-u>Unite file_rec/async:!<CR>
nnoremap <leader>g :<C-u>Unite grep:.<CR>

call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\ })
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --line-numbers --nocolor --nogroup --hidden --skip-vcs-ignores'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_rec_async_command =
                \ 'ag --follow --nocolor --nogroup --hidden --skip-vcs-ignores -g ""'
endif
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" }}}

" airline {{{
let g:airline_theme = 'hybridline'
let g:airline_powerline_fonts = 1
" }}}

" fugitive {{{
nnoremap <leader>gs :Gstatus<CR>
" }}}

" Line Return {{{
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}

" Backups {{{

set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" }}}

" Vim {{{
augroup ft_vim
	au!

	au FileType vim setlocal foldmethod=marker
augroup END
" }}}

" delimitmate {{{
let delimitMate_expand_cr = 1
au FileType python let b:delimitMate_nesting_quotes = ['"']
" }}}
