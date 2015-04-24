" initalization {{{
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
 if &compatible
   set nocompatible               " Be iMproved
 endif
endif

filetype plugin indent on
" }}}

" plugins {{{
call plug#begin('~/.vim/plugged')


Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'

Plug 'benmills/vimux'
" Plug 'jpalardy/vim-slime'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'

Plug 'Shougo/unite.vim'
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak' }
  else
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  endif
endif

Plug 'ntpeters/vim-better-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'osyo-manga/vim-over'

Plug 'mtth/scratch.vim'
Plug 'wellle/targets.vim'

Plug 'hynek/vim-python-pep8-indent'
Plug 'justinmk/vim-sneak'
Plug 'hdima/python-syntax'
Plug 'ivanov/vim-ipython'

Plug 'freeo/vim-kalisi'
Plug 'w0ng/vim-hybrid'
Plug 'chriskempson/base16-vim'
Plug 'whatyouhide/vim-gotham'
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'

Plug 'rmartinjak/vim-nesc'

Plug 'thinca/vim-qfreplace'

Plug 'benekastah/neomake'
Plug 'kassio/neoterm'
Plug 'vim-scripts/SyntaxRange'

Plug 'petRUShka/vim-opencl'

call plug#end()
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
set showtabline=0

set autoindent
set smartindent
set hidden

set incsearch
set ignorecase
set smartcase

set wrap
set textwidth=79
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

fun! StripTrailingWhiteSpace()
  " don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun
autocmd bufwritepre * :call StripTrailingWhiteSpace()

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
" let g:hybrid_use_Xresources = 1
set background=dark
colorscheme base16-harmonic16
let g:airline_theme = 'base16'
" colorscheme seoul256
" let g:gruvbox_termcolors=16
" colorscheme gruvbox
" let g:airline_theme = 'gruvbox'
" colorscheme hybrid
" let g:airline_theme = 'hybridline'
" colorscheme gotham
" let g:airline_theme = 'gotham'
" colorscheme apprentice
" let g:airline_theme = 'apprentice'
" colorscheme monokai
" let g:airline_theme = 'powerlineish'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts = 1

if has('gui_running')
  set guifont=Inconsolata-g\ For\ Powerline:h12
  set guioptions= " Nothing
endif
" }}}

" python {{{
let python_highlight_all = 1  " python-syntax
" let g:jedi#use_tabs_not_buffers = 0
" let g:jedi#use_splits_not_buffers = "left"
" let g:jedi#show_call_signatures = 0
" }}}

" fugitive {{{
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gps :Gpush<CR>
nnoremap <leader>gpl :Gpull<CR>
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

" ultisnips {{{
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}

" ctrlp {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif
" " }}}

nnoremap <Leader>a :Ag<Space>

autocmd! BufWritePost * Neomake
" nnoremap <Leader>c :Neomake!<CR>
" nnoremap <Leader>c :Dispatch<CR>

au BufNewFile,BufRead *.nc set filetype=nc

" autocmd FileType python setlocal makeprg=nosetests

autocmd Syntax * call SyntaxRange#Include('@begin=c@', '@end=c@', 'c', 'NonText')
autocmd Syntax * call SyntaxRange#Include('@begin=cl@', '@end=cl@', 'opencl', 'NonText')

tnoremap <Esc> <c-\><c-n>

" unite {{{
call unite#custom#profile('default', 'context', {
  \   'winheight': 20,
  \   'direction': 'botright',
  \ })
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async:!<CR>
" nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <leader>b :<C-u>Unite buffer<CR>
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :<C-u>Unite history/yank<CR>
nnoremap <leader>o :<C-u>Unite outline<CR>
nnoremap <leader><Space> :<C-u>Unite file_mru<CR>
nnoremap <Leader>g :<C-u>Unite grep:.<CR>

if executable('ag')
  let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
  \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif
" }}}

" vim-slime {{{
" let g:slime_target = "tmux"
" let g:slime_python_ipython = 1
" }}}

let g:better_whitespace_filetypes_blacklist=['markdown']
