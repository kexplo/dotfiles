if has('win32')
	"for clang_complete plugin (for windows)
	let g:clang_complete_auto = 1
	let g:clang_complete_copen = 1
	let g:clang_hl_errors = 1
	let g:clang_periodic_quickfix = 0
	let g:clang_snippets = 1
	let g:clang_conceal_snippets = 0
	let g:clang_exec = 'c:\\bin\\clang.exe'
	let g:clang_user_options = '|| exit 0'
	let g:clang_use_library = 1
	let g:clang_library_path = 'c:\\bin'
	let g:clang_debug = 0
endif

"colorscheme evening
colorscheme desert

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp949,latin1

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

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle 'tobyS/pdv'
Bundle 'SirVer/ultisnips'
Bundle 'Syntastic'
Bundle 'pathogen.vim'
Bundle 'taglist.vim'
Bundle 'Command-T'
"Bundle 'AutoComplPop'
Bundle 'neocomplcache'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
" hex mode
Bundle 'hexman.vim'

if has('win32')
	"transparency windows vim (windows gvim)
	Bundle 'VimTweak'
	Bundle 'mattn/transparency-windows-vim'
endif

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..


" ======= neocomplcache =============
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
"let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion, which require computational power and may stall the vim. 
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


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
let g:pymode_rope = 1
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

"tab변환 사용안함.
set noexpandtab
"eol 추가 막기
"set binary noeol

"map <F4> :TlistToggle<CR><CR>
" insert current timestamp
nmap <F5> a<C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR><Esc>
imap <F5> <C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR>



