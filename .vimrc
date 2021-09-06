"==============================================================================
" Basic configs
"==============================================================================

" vim:ft=vim:et:ts=2:sw=2:sts=2:
" encoding 설정이 맨 위에 있어야 gvim에서 메뉴가 깨지지 않는다.
set encoding=utf-8
set fileformats=unix,mac,dos
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1
set noswapfile
set nocompatible
set nofoldenable

" use softtab
set expandtab
"set tab size
set tabstop=4
set sw=4
set sts=4
set autoindent

"use backspace
set bs=indent,eol,start

" Highlight search
set hls

" tab visualize
"  examples:
"   set list lcs=tab:\|\
"   set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
set list lcs=tab:\|·

"syntax highlight on
syntax on

colorscheme desert

let s:windows = has('win32') || has('win64')
let s:macos = has('mac')

if s:windows
  language messages ko_kr.utf-8
else
  if !has('nvim')
    set term=xterm-256color
  endif
endif

if has('nvim')
  let g:loaded_ruby_provider = 1
endif

if has('gui_running')
  "set gvim font
  set guifont=consolas:h10
  set lines=40
  set columns=158
endif

"==============================================================================
" Plugins
"==============================================================================

" vim-plug
call plug#begin('~/.vim/plugged')

" On-demend loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'tpope/vim-sensible'

" LSP Plugins
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_diagnostics_echo_delay = 0
  let g:lsp_document_code_action_signs_enabled = 0
  let g:lsp_settings_filetype_python = ['jedi-language-server']
  let g:lsp_settings_filetype_go = ['golangci-lint-langserver', 'gopls']
  let g:lsp_settings = {
\   'yaml-language-server': {
\     'workspace_config': {
\       'yaml': {
\         'schemas': {
\           'kubernetes': '*',
\         }
\       }
\     }
\   }
\ }

Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"------------------------------------------------------------------------------

Plug 'dense-analysis/ale', { 'for': ['make', 'python', 'sh', 'dockerfile'] }
Plug 'majutsushi/tagbar'  " ctags required
Plug 'vim-airline/vim-airline'
  let g:airline#extensions#tabline#enabled = 1
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sleuth'
Plug 'RRethy/vim-illuminate'
Plug 'wellle/context.vim'
  let g:context_enabled = 1
Plug 'hotwatermorning/auto-git-diff'
Plug 'sheerun/vim-polyglot'
Plug 'sbdchd/neoformat'
  let g:neoformat_enabled_python = ['autopep8', 'isort']
  let g:neoformat_run_all_formatters = 1

if has('nvim')
  Plug 'kexplo/koach.nvim'
endif

Plug 'Yggdroot/indentLine'
  let g:indentLine_char = '┆'
  let g:indentLine_color_term = 239
  let g:indentLine_color_gui = '#A4E57E'

  augroup off_indentline_when_slow_filetypes
    autocmd!
    autocmd FileType * let g:indentLine_enabled = 1
    autocmd FileType * let g:indentLine_setConceal = 0
    autocmd FileType json,yaml let g:indentLine_enabled = 0
    autocmd FileType json,yaml let g:indentLine_setConceal = 0
  augroup END

" customizing any colorscheme via '~/.vim/after/colors'
Plug 'vim-scripts/AfterColors.vim'

" continuously updated session files
Plug 'tpope/vim-obsession'

Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'rhysd/clever-f.vim'
Plug 'easymotion/vim-easymotion'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'Glench/Vim-Jinja2-Syntax'

" typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'Shougo/vimproc.vim'

Plug 'tpope/vim-fugitive'

call plug#end()

"==============================================================================

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
  autocmd BufWritePre *.go undojoin | Neoformat
augroup END

"==============================================================================
" FZF
"==============================================================================

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right'), <bang>0)

if executable('rg')
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep('rg ' .
        \   '--color=always ' .
        \   '--glob "!.git/*" ' .
        \   '--line-number ' .
        \   '--column ' .
        \   '--no-heading ' .
        \   '--hidden ' .
        \   '--ignore-file=.gitignore ' .
        \   '--follow '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview('right:50%'),
        \   <bang>0)

  " with '--ignore-case'
  command! -bang -nargs=* Rgi
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

  " with '--line-regexp'
  command! -bang -nargs=* Rgw
        \ call fzf#vim#grep('rg ' .
        \   '--color=always ' .
        \   '--glob "!.git/*" ' .
        \   '--ignore-case ' .
        \   '--line-number ' .
        \   '--column ' .
        \   '--no-heading ' .
        \   '--word-regexp ' .
        \   '--hidden ' .
        \   '--ignore-file=.gitignore ' .
        \   '--follow '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview('right:50%'),
        \   <bang>0)
endif

"==============================================================================
" Key mappings
"==============================================================================

nnoremap <F4> :LspDocumentDiagnostics<CR><CR>
nnoremap <F12> :LspDefinition<CR>
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap K :LspHover<CR>
" nnoremap <F12> :tab split<cr>:LspDefinition<cr>
" nnoremap <F12> :sp<cr>:LspDefinition<cr>
" nnoremap <F12> :vsp<cr>:LspDefinition<cr>
" call fzf.vim Files
nnoremap <C-P> :Files<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprev<CR>

" Copy to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" Paste from system clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Move to line (easymotion)
map <leader><leader>l <Plug>(easymotion-bd-jk)
nmap <leader><leader>l <Plug>(easymotion-overwin-line)

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

" fzf
autocmd vimrc VimEnter *
\ if exists(':Rg')
\|  nnoremap <leader>aa :Rg<Space>
\|  nnoremap <leader>aw :Rg <C-R><C-W><CR>
\|  vnoremap <leader>av y:Rg <C-R>"<CR>
\|endif

" insert current datetime
nmap <F5> a<C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR><Esc>
imap <F5> <C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR>

" remove ESC delay (neovim)
augroup fast_esc
  autocmd!
  autocmd InsertEnter * set ttimeoutlen=0
  autocmd InsertLeave * set ttimeoutlen=100
augroup END

"==============================================================================

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

" Load local config
if filereadable($HOME . '/.vimrc.local')
  source $HOME/.vimrc.local
endif
