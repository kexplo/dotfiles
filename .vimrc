"colorscheme evening
colorscheme desert

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp949,latin1
set enc=utf-8

if has('win32')
	language messages ko_kr.utf-8
else
	"for fish shell
	if &shell =~# 'fish$'
		set shell=/bin/bash
		set term=xterm-256color
	endif
endif

"백스페이스 사용
set bs=indent,eol,start

"탭 크기 설정
set tabstop=4
set sw=4

"검색어 강조
set hls

"커서 위치 항상 표시
set ru

"파일 종류 자동 인식
filet plugin indent on

"syntax highlight on
syntax on

"자동 들여쓰기
set ai
"똑똑한 들여쓰기
set si
"c 들여쓰기 사용안함
set nocindent

"google protocol buffer
au BufRead,BufNewFile *.proto set filetype=proto
au! Syntax proto source $VIM\vimfiles\syntax\proto.vim

if has('gui_running')
	"set gvim font
	set guifont=consolas:h10
endif

set laststatus=2
"set statusline=%h%F%m%r%=[%l:%c(%p%%)]
"set statusline=%<%F%h%m%r%h%w%y\ %{strftime(\"%Y/%m/%d-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P
"set statusline=%<%F%w%h%m%r[%{&ff}/%Y][%{getcwd()}]%=(col:%c%V\ pos:%o\ line:%l\,%L\ %p%%)

"======= settings for vundle ===================
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" php document for vim
Plugin 'tobyS/pdv'
" ultimate solution for snippets in Vim (integrates with YouCompleteMe)
Plugin 'SirVer/ultisnips'
" a code-completion engine for Vim
Plugin 'Valloric/YouCompleteMe'
" syntax checking plugin for Vim
Plugin 'Syntastic'
Plugin 'pathogen.vim'
Plugin 'taglist.vim'
Plugin 'Command-T'
Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/nerdtree'
Plugin 'klen/python-mode'
" hex mode
Plugin 'hexman.vim'
Plugin 'Yggdroot/indentLine'

if has('win32')
	"transparency windows vim (windows gvim)
	Plugin 'VimTweak'
	Plugin 'mattn/transparency-windows-vim'
endif

call vundle#end()             " required!
filetype plugin indent on     " required!
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1
let g:ycm_extra_conf_globlist = ['~/.vim/*']
" ========== YcmCompleter subcommands =============
" :YcmCompleter GoToDeclaration
" :YcmCompleter GoToDefinition
" :YcmCompleter GoToDefinitionElseDeclaration
"
" You may also want to map the subcommands to something less verbose; for
" instance, nnoremap <leader>jd :YcmCompleter
" GoToDefinitionElseDeclaration<CR> maps the <leader>jd sequence to the longer
" subcommand invocation.
"
" The various GoTo* subcommands add entries to Vim's jumplist so you can use
" CTRL-O to jump back to where you where before invoking the command (and
" CTRL-I to jump forward; see :h jumplist for details).

" ========== NerdTree setting =============
map <F2> :NERDTreeToggle<CR>

" ========== python-mode settings =============
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

" == Highlight excess line length (python) == 
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80 
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
augroup END

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

"tab변환 사용안함.
set noexpandtab
"eol 추가 막기
"set binary noeol

"map <F4> :TlistToggle<CR><CR>
" insert current timestamp
"nmap <F5> a<C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR><Esc>
"imap <F5> <C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR>

"cpp, h switch
" :e %<.cpp
" :e %<.h
