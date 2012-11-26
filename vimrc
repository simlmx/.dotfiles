"
" MY STUFF
"

" pathogen
call pathogen#infect()

:set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" coffee
filetype plugin indent on
au BufNewFile,BufReadPost *.coffee setl shiftwidth=4 expandtab tabstop=4 softtabstop=4
au BufWritePost *.coffee silent CoffeeMake! | cwindow | redraw!

" code completion?
filetype plugin on
set ofu=syntaxcomplete#Complete

set number
set gfn=Monaco:h14
" sauf que ca en haut jveux pas ca juste pour la programmation?? en tous cas..

" sage
au BufNewFile,BufRead *.sage set filetype=python

" Pour shift-left, shift-right
"if has("gui_macvim")
"    let macvim_hig_shift_movement = 1
"endif
"
"nnoremap <silent> <F2> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>
"imap <F2> <c-o><F2>

nmap <F2> :w<cr>
" bash like <tab>
set wildmode=longest,list
set wildmenu

set clipboard=unnamed

set wildignore+=*/workspace/platform/build/*
set wildignore+=*.so,*.swp,*.zip
set wildignore+=*/rtb/experiment/results/*

" CTRL P
nmap <C-b> :CtrlPBuffer<CR>

" NERD tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <C-N> :NERDTreeToggle<CR>

" python-mode
let g:pymode_lint_ignore = "E251,E401,E501,E231"
let g:pymode_lint_cwindow = 0

" solarized
syntax enable
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

" no backup
set nobackup

"
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
" For tmux
set ttymouse=xterm2

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

