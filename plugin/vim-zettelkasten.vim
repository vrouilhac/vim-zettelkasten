" A Vim plugin that tries to put the Zettelkasten workflow's power right at your fingertips.
" 
" Last update : 2022 Apr 08
" Maintainer  : Vincent Rouilhac [vincentrouilhac.com ; vrouilhacpe@gmail.com]
" Version     : 1.2

if exists("g:loaded_zettelkasten")
  finish
endif
let g:loaded_zettelkasten = 1

" Options
if !exists("g:ztl_default_slipbox_location")
  let g:ztl_default_slipbox_location = 'slipbox'
endif

func s:open_file(filename)
  echom a:filename
  execute 'edit' a:filename
endfunc

func s:popup_close_callback(id, result)
  if a:result == -1
    return
  endif

  let i = split(system('ls ' . g:ztl_default_slipbox_location), '\n')
  let file_name = g:ztl_default_slipbox_location . '/' . i[a:result-1]
  call s:open_file(file_name) 
endfunc

func FilterHandler(id, key)
  echom a:id
  echom a:key
  if a:key == 'o'
    call popup_close(a:id, 1)
    return 1 
  endif
  if a:key == 'a'
    let filename = input("File name: ")
    echom filename
    call s:open_file(g:ztl_default_slipbox_location . '/' . filename)
    call popup_close(a:id, -1)
    return 1
  endif
  if a:key == '<C-C>'
    call popup_close(a:id, -1)
    return 1
  endif

  return popup_filter_menu(a:id, a:key)
endfunc

func s:find_zettels()
  echom win_getid()
  let i = split(system('ls ' . g:ztl_default_slipbox_location), '\n')
  let id = popup_menu(i, #{ filter: 'FilterHandler', callback: 's:popup_close_callback' })
endfunc

nnoremap ,zf :call s:find_zettels()<CR>
nnoremap ,zh :-1read $HOME/.vim/bundle/vim-zettelkasten/snippets/ztl-metadata.ztl<cr>2jA
nnoremap ,zr :-1read $HOME/.vim/bundle/vim-zettelkasten/snippets/ztl-refs.ztl<CR>jA
nnoremap ,zt :! node $HOME/.vim/bundle/vim-zettelkasten/scripts/ztl_timestamp.js > $HOME/.vim/bundle/vim-zettelkasten/scripts/timestamp.txt<CR>$:read $HOME/.vim/bundle/vim-zettelkasten/scripts/timestamp.txt<CR>d$k$pjddk
