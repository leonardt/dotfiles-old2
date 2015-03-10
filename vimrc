" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
 if &compatible
   set nocompatible               " Be iMproved
 endif

 " Required:
 set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

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
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'hynek/vim-python-pep8-indent'
" NeoBundle 'justinmk/vim-sneak'
NeoBundle 'hdima/python-syntax'
NeoBundle 'lokaltog/vim-easymotion'

NeoBundle 'w0ng/vim-hybrid'

call neobundle#end()
filetype plugin indent on

NeoBundleCheck

set encoding=utf-8

syntax on

let mapleader = "\<Space>"

set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set tabstop=2

set autoindent
set smartindent
set hidden

set incsearch
set ignorecase
set smartcase

set wrap
set textwidth=80

" set number
" set relativenumber

set cursorline

set noshowmode

set mouse=a
set lazyredraw
set hidden
set fcs=vert:│

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:hybrid_use_Xresources = 1
colorscheme hybrid

" Neocomplete
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

" easymotion
map <Leader> <Plug>(easymotion-prefix)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

" python-syntax
let python_highlight_all = 1

" unite
nnoremap <leader>b :<C-u>Unite buffer<CR>
nnoremap <leader>f :<C-u>Unite file_rec/async:!<CR>
nnoremap <leader>g :<C-u>Unite grep:.<CR>

call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 10,
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
