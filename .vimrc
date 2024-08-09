" vim:ft=vim:et:ts=2:sw=2:sts=2:

"
" Basic configs
"

" encoding 설정이 맨 위에 있어야 gvim에서 메뉴가 깨지지 않는다.
set encoding=utf-8
set fileformats=unix,mac,dos
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1
set noswapfile
set nocompatible
set nofoldenable
set hls

"use backspace
set bs=indent,eol,start

" tab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" tab visualize
"  examples:
"   set list lcs=tab:\|·
"   set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
if !has('nvim')
  set list lcs=tab:\|·
else
  set list lcs=tab:\▎·
endif

" indentation
set autoindent

"syntax highlight on
syntax on

colorscheme desert

"
" Terminal or OS specific configs
"

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

set termguicolors

if has('nvim')
  let g:loaded_ruby_provider = 1
  set inccommand=split
endif

" =============================================================================

"
" Plugins
"

" use vim-plug
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
Plug 'hotwatermorning/auto-git-diff'
Plug 'sheerun/vim-polyglot'
Plug 'sbdchd/neoformat'
  let g:neoformat_enabled_python = ['autopep8', 'isort', 'black', 'ruff']
  let g:neoformat_run_all_formatters = 1

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

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'Glench/Vim-Jinja2-Syntax'

" typescript & jsx
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
  " set filetypes as typescriptreact
  augroup set_filetypes_as_typescriptreact
    autocmd!
    autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
  augroup END
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['javascript', 'typescript', 'typescriptreact'] }
Plug 'maxmellon/vim-jsx-pretty', {  'for': ['javascript', 'typescript', 'typescriptreact'] }

Plug 'tpope/vim-fugitive'

if !has('nvim') " vim(not neovim) plugins
  Plug 'scrooloose/nerdtree'
    let NERDTreeShowHidden=1  " always show hidden files

  Plug 'wellle/context.vim'
    let g:context_enabled = 1

  " LSP Plugins
  Plug 'prabirshrestha/vim-lsp'
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_diagnostics_echo_delay = 0
    let g:lsp_document_code_action_signs_enabled = 0
    let g:lsp_settings_filetype_python = ['jedi-language-server']
    let g:lsp_settings_filetype_go = ['golangci-lint-langserver', 'gopls']

  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'liuchengxu/vista.vim'
    let g:vista_default_executive = 'vim_lsp'

else " neovim plugins

  Plug 'kyazdani42/nvim-web-devicons'
  "Plug 'kyazdani42/nvim-tree.lua'

  " LSP plugins
  " It's important to set up the plugins in the following order:
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'

  " LSP plugins
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path' " nvim-cmp path source for filesystem path

  " Plug 'mfussenegger/nvim-lint'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-context'

  Plug 'mfussenegger/nvim-dap'
  Plug 'nvim-lua/plenary.nvim'  " dependency for diffview.nvim
  Plug 'sindrets/diffview.nvim'
  Plug 'hedyhli/outline.nvim'

  Plug 'folke/trouble.nvim'
  Plug 'ray-x/lsp_signature.nvim'

  Plug 'MunifTanjim/nui.nvim' " for neo-tree
  Plug 'nvim-lua/plenary.nvim' " for neo-tree
  Plug 'nvim-neo-tree/neo-tree.nvim'

  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'cuducos/yaml.nvim'

  Plug 'nvim-telescope/telescope.nvim'

  Plug 'github/copilot.vim'

  Plug 'danymat/neogen'
endif

call plug#end()

"
" neovim plugin configs
"
if has('nvim')

  " lsp plugin configs
  lua << EOF
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        --vim.keymap.set('n', '<space>wl', function()
        --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, opts)
        --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        --vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('mason').setup()
    require('mason-lspconfig').setup()
    local lspconfig = require('lspconfig')
    lspconfig.jedi_language_server.setup {}
    lspconfig.gopls.setup {}
    lspconfig.golangci_lint_ls.setup {}
    lspconfig.bashls.setup {}
    lspconfig.eslint.setup {}
    lspconfig.tsserver.setup {}
    lspconfig.ruff_lsp.setup {}
    lspconfig.rust_analyzer.setup {}

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
EOF

  lua << EOF
    require("trouble").setup {
      position = "bottom"
    }
EOF

  lua << EOF
    require("nvim-treesitter.configs").setup {
      ensure_installed = {'c', 'vimdoc', 'vim', 'bash', 'c_sharp', 'cmake', 'cpp', 'css', 'cuda', 'diff', 'dockerfile', 'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'go', 'gosum', 'gomod', 'graphql', 'hcl', 'hlsl', 'html', 'htmldjango', 'http', 'ini', 'javascript', 'jq', 'json', 'json5', 'ledger', 'lua', 'luadoc', 'make', 'markdown', 'mermaid', 'proto', 'python', 'regex', 'rust', 'sql', 'terraform', 'tsx', 'typescript', 'yaml'},
      highlight = {
        enable = true,
        -- workaround for performance degraded issue
        -- REF: https://github.com/nvim-treesitter/nvim-treesitter/issues/556#issuecomment-1157664778
        disable = function(lang, bufnr)
          return lang == "vim"
        end,
        additional_vim_regex_highlighting = false,
      },
    }

    require("treesitter-context").setup {
      enable = true,
      max_lines = 0, -- no limit
      trim_scope = 'outer',
      zindex = 20,
      mode = 'cursor',
      separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
    }
EOF

lua << EOF
  require('neo-tree').setup({
   filesystem = {
     bind_to_cwd = false, -- true creates a 2-way binding between vim's cwd and neo-tree's root
     filtered_items = {
       hide_dotfiles = false,
       hide_hidden = false,
     }
   },
   source_selector = {
     winbar = true,
   }
  })
EOF

lua require('outline').setup()

lua << EOF
  -- indent-blankline
  require("ibl").setup()
EOF

lua << EOF
require('illuminate').configure({
  providers = {
    'lsp',
    'treesitter',
    'regex',
  }
})
EOF

lua << EOF
require('neogen').setup {
  enabled = true
}
EOF

lua << EOF
require('lsp_signature').setup()
EOF

endif

"
" augroup defines
"

augroup vimrc
  autocmd!
augroup END

" MSBuild
augroup filetype_msbuild
  autocmd!
  autocmd BufRead,BufNewFile Directory.Build.props setfiletype xml
  autocmd BufRead,BufNewFile Directory.Build.targets setfiletype xml
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

"
" FZF config
"

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

"
" Key mappings
"

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
else
  nnoremap <F4> :Trouble diagnostics toggle<CR>
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
  "map <F2> :NvimTreeToggle<CR>
  map <F2> :Neotree toggle left reveal_force_cwd<CR>
endif

" Symbols
autocmd vimrc VimEnter *
\ if exists(':Vista')
\|  map <F3> :Vista<CR>
\|elseif exists(':Outline')
\|  map <F3> :Outline<CR>
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

" disable fzf.vim's Windows command
" ref: https://github.com/junegunn/fzf.vim/issues/1084
command! -nargs=* W w

" Load local config
if filereadable($HOME . '/.vimrc.local')
  source $HOME/.vimrc.local
endif
