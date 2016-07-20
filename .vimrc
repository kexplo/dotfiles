set nocompatible               " be iMproved
" use softtab
set noexpandtab

"colorscheme evening
colorscheme desert

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp949,latin1
set encoding=utf-8

if has('win32')
	language messages ko_kr.utf-8
else
	"for fish shell
	if &shell =~# 'fish$'
		set shell=/bin/bash
		set term=xterm-256color
	elseif &shell =~# 'zsh$'
		set term=xterm-256color
	endif
endif

"use backspace
set bs=indent,eol,start

"set tab size
set tabstop=4
set sw=4
set sts=4

"검색어 강조
set hls

"커서 위치 항상 표시
"set ru

"파일 종류 자동 인식
filetype plugin indent on

"syntax highlight on
syntax on

set autoindent

"google protocol buffer
au BufRead,BufNewFile *.proto set filetype=proto
au! Syntax proto source $VIM\vimfiles\syntax\proto.vim

if has('gui_running')
	"set gvim font
	set guifont=consolas:h10
endif

" set status line always visible
set laststatus=2

"======= plugins ==============================================================

" vim-plug
call plug#begin('~/.vim/plugged')

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demend loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'taglist.vim'
Plug 'Command-T'
Plug 'Lokaltog/vim-powerline', { 'branch': 'develop' }
Plug 'klen/python-mode', { 'for': 'python' }

" hex mode
Plug 'hexman.vim'
Plug 'Yggdroot/indentLine'

" customizing any colorscheme
Plug 'AfterColors.vim'

" continuously updated session files
Plug 'tpope/vim-obsession'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'

if has('win32')
	"transparency windows vim (windows gvim)
	Plug 'VimTweak'
	Plug 'mattn/transparency-windows-vim'
endif

call plug#end()

"==============================================================================

" Highlight excess line length (python)
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80 
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%81v.*/
    autocmd FileType python set nowrap
augroup END
"set colorcolumn=81

" -- ultisnips settings  ------------------------------------------------------
" Trigger configuration.
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-snippets/UltiSnips']

" set python docstring style
let g:ultisnips_python_style="sphinx"

" -- YCM settings  ------------------------------------------------------------

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1
let g:ycm_extra_conf_globlist = ['~/.vim/*']

" -- NerdTree settings  -------------------------------------------------------

map <F2> :NERDTreeToggle<CR>

" -- python-mode settings  ----------------------------------------------------

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0
"disable run python code
let g:pymode_run = 0 

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
" Switch pylint, pyflakes, pep8, mccabe code-checkers
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1
" Skip errors and warnings
" E.g. "E501,W002"
let g:pymode_lint_ignore = "W191"


" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" hexmap key mapping
map <F6> <Plug>HexManager
"<leader> hm	HexManager: Call/Leave Hexmode (using xxd) 
"<leader> hd  	HexDelete: delete hex character under cursor 
"<leader> hi  	HexInsert: Insert Ascii character before cursor 
"<leader> hg  	HexGoto: Goto hex offset. 
"<leader> hn  	HexNext: Goto next hex offset. 
"<leader> hp  	HexPrev: Goto previous hex offset. 
"<leader> hs  	HexStatus: Show / Hide hexoffset infos in statusline 
"                         and related ascii column 

" Taglist Cmd
" :TlistToggle	open/close the taglist window.
" :TlistUpdate	update the tags for the current buffer.
"
"
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'

"tab visualize
set list lcs=tab:\|\ 

"eol 추가 막기
"set binary noeol

" insert current timestamp
"nmap <F5> a<C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR><Esc>
"imap <F5> <C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR>

"cpp, h switch
" :e %<.cpp
" :e %<.h
"
"My Custom KeyMapping
nnoremap <F4> :TlistToggle<CR><CR>
nnoremap <F12> :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F7> :PymodeLint<CR><CR>

"key memo
"Ctrl-E, Ctrl-Y // up down scroll without moving the cursor
"Ctrl-u // moves screen up 1/2 page
"Ctrl-d // moves screen down 1/2 page
"Ctrl-b // moves screen up one page
"Ctrl-f // moves screen down one page
"
"z-z // move current line to the middle of the screen
"z-t // move current line to the top of the screen
"z-b // move current line to the bottom of the screen
"
"
let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(pyc|exe|so|dll)$',
  \ }

" apt-get install silversearcher-ag
" ack.vim + the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  nnoremap <leader>aa :Ack!<Space>
  nnoremap <leader>aw :Ack! --literal '<C-R><C-W>'<CR>
  vnoremap <leader>av y:Ack! --literal '<C-R>"'<CR>
endif
