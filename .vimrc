" vim:ft=vim:et:ts=2:sw=2:sts=2:
" encoding 설정이 맨 위에 있어야 gvim에서 메뉴가 깨지지 않는다.
set encoding=utf-8

set noswapfile

if has('nvim')
  let g:loaded_ruby_provider = 1
endif

"======= plugins ==============================================================

" vim-plug
call plug#begin('~/.vim/plugged')

" On-demend loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'Valloric/YouCompleteMe' ", { 'do': './install.py' }
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'  " ctags required
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sleuth'

if has('nvim')
  Plug 'kexplo/koach.nvim'
endif

Plug 'Yggdroot/indentLine'

" customizing any colorscheme via '~/.vim/after/colors'
Plug 'vim-scripts/AfterColors.vim'

" continuously updated session files
Plug 'tpope/vim-obsession'

Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-unimpaired'

if has('win32')
  "transparency windows vim (windows gvim)
  Plug 'kexplo/vimtweak'
  Plug 'mattn/transparency-windows-vim'
endif

Plug 'Glench/Vim-Jinja2-Syntax'

" typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'Shougo/vimproc.vim'

call plug#end()

"==============================================================================

set nocompatible               " be iMproved
" use softtab
set expandtab
"set tab size
set tabstop=4
set sw=4
set sts=4
set autoindent

colorscheme desert

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp949,latin1
set fileformat=unix

"use backspace
set bs=indent,eol,start

" Highlight search
set hls

if has('win32')
  language messages ko_kr.utf-8
else
  if !has('nvim')
    "for fish shell
    if &shell =~# 'fish$'
      set shell=/bin/bash
      set term=xterm-256color
    elseif &shell =~# 'zsh$'
      set term=xterm-256color
    endif
  endif
endif

"syntax highlight on
syntax on

" disable folding as default
set nofoldenable

if has('gui_running')
  "set gvim font
  set guifont=consolas:h10
endif

augroup vimrc
  autocmd!
augroup END

" MSBuild
augroup filetype_msbuild
  autocmd!
  autocmd BufRead,BufNewFile Directory.Build.props setfiletype xml
  autocmd BufRead,BufNewFile Directory.Build.targets setfiletype xml
augroup END

"google protocol buffer
augroup filetype_proto
  autocmd!
  autocmd BufRead,BufNewFile *.proto setfiletype proto
  autocmd FileType proto source $VIM\vimfiles\syntax\proto.vim
augroup END

" .md Filetype mappings
augroup filetype_markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md setfiletype markdown
augroup END

" typescript filetype mappings
augroup filetype_typescript
  autocmd!
  autocmd BufRead,BufNewFile *.ts setfiletype typescript
augroup END

" tab/indent mappings
augroup indent_mappings
  autocmd!
  autocmd FileType cpp        setl ts=2 sw=2 sts=2
  autocmd FileType javascript setl ts=2 sw=2 sts=2
  autocmd FileType typescript setl ts=2 sw=2 sts=2
augroup END

" Highlight excess line length (python)
augroup filetype_python
  autocmd!
  " highlight characters past column 80
  autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType python match Excess /\%81v.*/
  autocmd FileType python set nowrap
  autocmd FileType python set colorcolumn=80
  autocmd FileType python set expandtab
augroup END

augroup filetype_go
  autocmd!
  autocmd FileType go set noexpandtab
  autocmd FileType go set shiftwidth=4
  autocmd FileType go set softtabstop=4
  autocmd FileType go set tabstop=4
augroup END

" YouCompleteMe
autocmd vimrc VimEnter *
\ if exists('g:ycm_goto_buffer_command')
\|  let g:ycm_goto_buffer_command = 'new-tab'
\|  let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
\|  let g:ycm_confirm_extra_conf = 1
\|  let g:ycm_extra_conf_globlist = ['~/.vim/*']
\|endif

" NerdTree
autocmd vimrc VimEnter *
\ if exists(':NERDTreeToggle')
\|  map <F2> :NERDTreeToggle<CR>
\|endif

" Tagbar
autocmd vimrc VimEnter *
\ if exists(':TagbarToggle')
\|  map <F3> :TagbarToggle<CR>
\|endif

" ALE
function! s:set_ale_options()
  "let g:ale_python_mypy_options = '--py2 --ignore-missing-imports --follow-imports=skip'
  " let g:ale_python_mypy_options = '--py2 --ignore-missing-imports'
endfunction
autocmd vimrc VimEnter * call s:set_ale_options()

let g:indentLine_char = '┆'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'

augroup except_slow_filetypes
  autocmd!
  autocmd FileType * let g:indentLine_enabled = 1
  autocmd FileType * let g:indentLine_setConceal = 0
  autocmd FileType json,yaml let g:indentLine_enabled = 0
  autocmd FileType json,yaml let g:indentLine_setConceal = 0
augroup END

" tab visualize
"  examples:
"   set list lcs=tab:\|\
"   set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
set list lcs=tab:\|·

" insert current datetime
nmap <F5> a<C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR><Esc>
imap <F5> <C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR>

" FZF
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right'), <bang>0)

if executable('rg')
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep('rg ' .
        \   '--color=always ' .
        \   '--glob "!.git/*" ' .
        \   '--ignore-case ' .
        \   '--line-number ' .
        \   '--column ' .
        \   '--no-heading ' .
        \   '--hidden ' .
        \   '--ignore-file=.gitignore ' .
        \   '--follow '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview('right:50%'),
        \   <bang>0)
endif

" Key mappings
nnoremap <F4> :TlistToggle<CR><CR>
nnoremap <F12> :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F7> :PymodeLint<CR><CR>
nnoremap <s-k> :YcmCompleter GetDoc<CR>
" call fzf.vim Files
nnoremap <C-P> :Files<CR>

" apt-get install silversearcher-ag
" ack.vim + the_silver_searcher
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
  nnoremap <leader>aa :Ack!<Space>
  nnoremap <leader>aw :Ack! '<C-R><C-W>'<CR>
  vnoremap <leader>av y:Ack! '<C-R>"'<CR>
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
  nnoremap <leader>aa :Ack!<Space>
  nnoremap <leader>aw :Ack! --literal '<C-R><C-W>'<CR>
  vnoremap <leader>av y:Ack! --literal '<C-R>"'<CR>
endif

" remove ESC delay (neovim)
augroup fast_esc
  autocmd!
  autocmd InsertEnter * set ttimeoutlen=0
  autocmd InsertLeave * set ttimeoutlen=100
augroup END

set mouse=v

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
"cpp, h switch
" :e %<.cpp
" :e %<.h
"
"prevent append EOF(End Of Line).
"set binary noeol
