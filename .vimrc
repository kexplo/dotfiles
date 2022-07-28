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
  if (&term == "win32" && &t_Co == 16)  " Vim on Windows Terminal
    " Fix color palette
    set t_Co=256
    " Fix background color render, https://github.com/microsoft/terminal/issues/832
    set t_ut=
  endif
else
  if !has('nvim')
    set term=xterm-256color
  endif
endif

if has('nvim')
  let g:loaded_ruby_provider = 1
  set inccommand=split
endif

if has('gui_running')
  "set gvim font
  set guifont=JetBrainsMonoNL_Nerd_Font_Mono:h10
  set lines=40
  set columns=158
endif

"==============================================================================
" Plugins
"==============================================================================

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'ryanoasis/vim-devicons'
Plug 'prabirshrestha/async.vim'
Plug 'dense-analysis/ale', { 'for': ['make', 'python', 'sh', 'dockerfile', 'markdown'] }
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
  let g:neoformat_enabled_python = ['autopep8', 'isort', 'black']
  let g:neoformat_run_all_formatters = 1

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
Plug 'junegunn/vim-easy-align'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'Glench/Vim-Jinja2-Syntax'

" typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'Shougo/vimproc.vim'

Plug 'tpope/vim-fugitive'

"------------------------------------------------------------------------------
if !has('nvim') " vim(not neovim) plugins only
  Plug 'scrooloose/nerdtree'
    let NERDTreeShowHidden=1  " always show hidden files

  " LSP Plugins
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
  Plug 'liuchengxu/vista.vim'
    let g:vista_default_executive = 'vim_lsp'
else " neovim plugins only
  Plug 'kexplo/koach.nvim'

  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path' " nvim-cmp path source for filesystem path
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'mfussenegger/nvim-dap'
  Plug 'nvim-lua/plenary.nvim'  " dependency for diffview.nvim
  Plug 'sindrets/diffview.nvim'
  Plug 'simrat39/symbols-outline.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'ray-x/lsp_signature.nvim'
endif

call plug#end()

if has('nvim')
  lua << EOF
    local nvim_lsp = require('lspconfig')
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      -- Enable completion triggered by <c-x><c-o>
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
      buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = { 'jedi_language_server', 'gopls' }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end

    local cmp = require("cmp")
    cmp.setup {
      sources = {
        { name = 'nvim_lsp'},
        {
          name = 'path',
          option = {
            trailing_slash = true
          },
        },
      },
      -- SEE: https://github.com/hrsh7th/nvim-cmp/issues/231#issuecomment-1098175017
      mapping = cmp.mapping.preset.insert()
    }

    require("trouble").setup {
      position = "right"
    }

    require("nvim-treesitter.configs").setup {
      ensure_installed = "maintained",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }

    require('nvim-tree').setup()

    require("lsp_signature").setup()
EOF
endif

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
  " highlight characters past column 160
  autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType python match Excess /\%161v.*/
  autocmd FileType python set nowrap
  autocmd FileType python set colorcolumn=160
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

if exists(':LspDocumentDiagnostics')
  " vim-lsp key mappings
  nnoremap <F4> :LspDocumentDiagnostics<CR><CR>
  nnoremap <F12> :LspDefinition<CR>
  nnoremap gd :LspDefinition<CR>
  nnoremap gr :LspReferences<CR>
  nnoremap K :LspHover<CR>
  " nnoremap <F12> :tab split<cr>:LspDefinition<cr>
  " nnoremap <F12> :sp<cr>:LspDefinition<cr>
  " nnoremap <F12> :vsp<cr>:LspDefinition<cr>
endif

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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
function! s:SmartNERDTreeToggle()
  " Call Close, if current buf is not modifiable and NERDTree is active
  if !&modifiable && exists("t:NERDTreeBufName")
    NERDTreeClose
  " Call Find, if current buf has name and modifiable
  elseif &modifiable && len(expand("%"))
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction

if !has('nvim')
  map <F2> :call <SID>SmartNERDTreeToggle()<CR>
else
  map <F2> :NvimTreeToggle<CR>
endif

" Symbols
autocmd vimrc VimEnter *
\ if exists(':Vista')
\|  map <F3> :Vista<CR>
\|elseif exists(':SymbolsOutline')
\|  map <F3> :SymbolsOutline<CR>
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
