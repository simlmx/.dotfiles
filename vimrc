"
" MY STUFF
"

" mark.vim, pre-pathogen
nmap <Leader>w <Plug>MarkSearchCurrentPrev
nmap <Leader>e <Plug>MarkSearchCurrentNext

" pathogen
call pathogen#infect()

" mark.vim
" let g:mwPalettes['simon'] = [
    " \   { 'ctermbg':'Cyan',       'ctermfg':'Black', 'guibg':'#8CCBEA', 'guifg':'Black' },
    " \   { 'ctermbg':'Green',      'ctermfg':'Black', 'guibg':'#A4E57E', 'guifg':'Black' },
    " \   { 'ctermbg':'Red',        'ctermfg':'Black', 'guibg':'#FF7272', 'guifg':'Black' },
    " \   { 'ctermbg':'Magenta',    'ctermfg':'Black', 'guibg':'#FFB3FF', 'guifg':'Black' },
    " \   { 'ctermbg':'Blue',       'ctermfg':'Black', 'guibg':'#9999FF', 'guifg':'Black' },
" \]
" let g:mwDefaultHighlightingPalette = 'simon'


set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" coffee
filetype plugin indent on
au BufNewFile,BufReadPost *.coffee setl shiftwidth=4 expandtab tabstop=4 softtabstop=4
au BufWritePost *.coffee silent CoffeeMake! | cwindow | redraw!

"html, yaml, latex
au BufNewFile,BufReadPost *.{html,css,js,xml,yml,yaml,tex,tsx,ts} setl shiftwidth=2 expandtab tabstop=2 softtabstop=2

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

" back to normal mode and save (why not)
imap jk <esc>:w<cr>

" switch between tabs
nmap <Leader>a :tabprevious<cr>
nmap <Leader>f :tabnext<cr>

" bash like <tab>
set wildmode=longest,list
set wildmenu

if $TMUX == ''
    set clipboard+=unnamed
endif

set wildignore+=*.so,*.swp,*.zip,*.pyc,*~

set colorcolumn=72,80,100,120

" make :W save, just like :w
:command W w
"************************
" plugin customizations
"************************

" CTRL P
nmap <Leader>p :CtrlPBuffer<CR>
" look into .ctrlpignore files, if present
let g:ctrlp_user_command = 'find %s -type f | grep -v 
    \"`if [ -f .ctrlpignore ];
    \then cat .ctrlpignore; fi;
    \if [ -f ~/.ctrlpignore ];
    \then cat ~/.ctrlpignore; fi;`"'
let g:ctrlp_max_files=0
let g:ctrlp_working_path_mode = ''
let g:ctrlp_open_multiple_files = 'h'

" NERD tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" nmap <C-N> :NERDTreeToggle<CR>

" NERD commenter
let NERDSpaceDelims = 1
let NERDUsePlaceHolders = 0

" python-mode
let g:pymode_lint_ignore = "E251,E401,E501,E231,E302,E225,E128,E127,E203"
let g:pymode_lint_cwindow = 0
set nofoldenable
autocmd CompleteDone * pclose
let g:pymode_rope = 0
let g:pymode_options_max_line_length = 88
let g:pymode_folding = 0
let g:pymode_python = 'python3'


" color theme
syntax enable
set background=dark
"let g:solarized_termtrans = 1
"colorscheme solarized
colorscheme gruvbox
" some fix for tmux
set t_ut=

" ctags
" set tags=./tags;/
"au BufWritePost *.cc,*.c,*.cpp,*.h !ctags -R &

" taglist
nnoremap <silent> <C-N> :TlistToggle<CR>
let Tlist_WinWidth=34

" FSwitch
au! BufEnter *.cc,*.c let b:fswitchdst = 'h'
au! BufEnter *.h let b:fswitchdst = 'cc,c'
nmap <Leader>s :FSHere<CR>



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
  " autocmd FileType text setlocal textwidth=78

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

" TODO make a function for that maybe because sometimes it's horrible
" use the shell's background, I need it for the transparency
" hi Normal ctermbg=none
