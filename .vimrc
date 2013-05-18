"for clang_complete plugin (for windows)
"let g:clang_complete_auto = 1
"let g:clang_complete_copen = 1
"let g:clang_hl_errors = 1
"let g:clang_periodic_quickfix = 0
"let g:clang_snippets = 1
"let g:clang_conceal_snippets = 0
"let g:clang_exec = 'c:\\bin\\clang.exe'
"let g:clang_user_options = '|| exit 0'
"let g:clang_use_library = 1
"let g:clang_library_path = 'c:\\bin'
"let g:clang_debug = 0
"-------------------------------

set shell=/bin/bash

"colorscheme evening
colorscheme desert

set nocompatible

set fileencoding=utf-8

"백스페이스 사용
set bs=indent,eol,start

set tabstop=4
set sw=4

"검색어 강조
set hls

"파일 종류 자동 인식
filetype on

"커서 위치 표시
set ru

filet plugin indent on
syntax on

set ai
set si
set nocindent
set noexpandtab

"google protocol buffer
au BufRead,BufNewFile *.proto set filetype=proto
au! Syntax proto source $VIM\vimfiles\syntax\proto.vim

"set gvim font
set guifont=consolas:h10

set laststatus=2
"set statusline=%h%F%m%r%=[%l:%c(%p%%)]
"set statusline=%<%F%h%m%r%h%w%y\ %{strftime(\"%Y/%m/%d-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P
"set statusline=%<%F%w%h%m%r[%{&ff}/%Y][%{getcwd()}]%=(col:%c%V\ pos:%o\ line:%l\,%L\ %p%%)

if v:lang =~ "^ko"
  set encoding=cp949
  set fileencodings=utf-8,cp949
  set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~ "^ja_JP"
  set fileencodings=euc-jp
  set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~ "^zh_TW"
  set fileencodings=big5
  set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~ "^zh_CN"
  set fileencodings=gb2312
  set guifontset=*-r-*
endif
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set encoding=utf-8
  set fileencodings=utf-8,cp949
endif

" 80 column layout
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/


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
"Bundle 'Lokaltog/powerline'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'

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

"----------jedi-vim settings-------
"let g:jedi#use_tabs_not_buffers = 1
"let g:jedi#auto_initialization = 1,
"let g:jedi#auto_vim_configuration=  1
"let g:jedi#goto_command = '<leader>g'
"let g:jedi#autocompletion_command =  '<C-Space>'
"let g:jedi#get_definition_command = '<leader>d'
"let g:jedi#related_names_command = '<leader>n'
"let g:jedi#rename_command = '<leader>r'
"let g:jedi#popup_on_dot = 1
"let g:jedi#pydoc = 'K'
"let g:jedi#show_function_definition = 1
"let g:jedi#function_definition_escape = '≡'
"let g:jedi#auto_close_doc = 1
"let g:jedi#popup_select_first = 1

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

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion, which require computational power and may stall the vim. 
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


" == powerline setting ==
"set rtp+=~/.vimrc/bundle/powerline/powerline/bindings/vim

" == NerdTree setting ==
map <F2> :NERDTreeToggle<CR>

" == python-mode settings ==
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
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END
