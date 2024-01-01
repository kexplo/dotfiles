if exists(':GuiTabline')
  GuiTabline 0
endif

if exists(':GuiPopupmenu')
  GuiPopupmenu 0
endif

if exists(':GuiFont')
  GuiFont JetBrainsMonoNL Nerd Font Mono:h10
endif

nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
