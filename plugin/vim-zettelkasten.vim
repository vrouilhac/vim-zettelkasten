" A Vim plugin that tries to put the Zettelkasten workflow's power right at your fingertips.
" 
" Last update : 2022 Apr 09
" Maintainer  : Vincent Rouilhac [vincentrouilhac.com ; vrouilhacpe@gmail.com]
" Version     : 1.3

if exists("g:loaded_zettelkasten")
  finish
endif
let g:loaded_zettelkasten = 1

" Options
if !exists("g:ztl_default_slipbox_location")
  let g:ztl_default_slipbox_location = 'slipbox'
endif

if !exists("g:ztl_default_references_location")
  let g:ztl_default_references_location = 'references'
endif

" ---

func s:open_file(filename)
  execute 'edit' a:filename
endfunc

func s:popup_close_callback_zettels(id, result)
  if a:result == -1
    return
  endif

  let i = split(system('ls ' . g:ztl_default_slipbox_location), '\n')
  let file_name = g:ztl_default_slipbox_location . '/' . i[a:result-1]
  call s:open_file(file_name) 
endfunc

func s:popup_close_callback_references(id, result)
  if a:result == -1
    return
  endif

  let i = split(system('ls ' . g:ztl_default_references_location), '\n')
  let file_name = g:ztl_default_references_location . '/' . i[a:result-1]
  call s:open_file(file_name) 
endfunc



func s:popup_close_tag_found_callback(id, result)
  if a:result == -1
    return
  endif

  let tag = getreg("a")
  let l:list = split(strtrans(system('grep -l "' . tag . '" ' . g:ztl_default_slipbox_location . '/*.ztl')), '\^@')
  let l:filename = l:list[a:result-1]
  call s:open_file(l:filename) 
endfunc

func s:popup_tags_close_callback(i, result)
  if a:result == -1
    return
  endif

  let l:tags_list = s:get_ztl_tags_list()
  let tag = split(l:tags_list[a:result-1], " ")[1]
  call setreg("a", tag, getregtype("a"))
  let l:list = split(strtrans(system('grep -l "' . tag . '" ' . g:ztl_default_slipbox_location . '/*.ztl')), '\^@')
  let id = popup_menu(l:list, #{ filter: 's:filter_handler', callback: 's:popup_close_tag_found_callback' })
endfunc

func s:filter_handler(id, key)
  if a:key == 'o'
    call popup_close(a:id, 1)
    return 1 
  endif
  if a:key == '<C-C>'
    call popup_close(a:id, -1)
    return 1
  endif

  return popup_filter_menu(a:id, a:key)
endfunc

func s:filter_handler_references(id, key)
  call s:filter_handler(a:id, a:key)

  if a:key == 'a'
    let filename = input("File name: ")
    call s:open_file(g:ztl_default_references_location . '/' . filename)
    call popup_close(a:id, -1)
    return 1
  endif
endfunc

func s:filter_handler_zettels(id, key)
  call s:filter_handler(a:id, a:key)

  if a:key == 'a'
    let filename = input("File name: ")
    call s:open_file(g:ztl_default_slipbox_location . '/' . filename)
    call popup_close(a:id, -1)
    return 1
  endif
endfunc

func s:find_zettels()
  let i = split(system('ls ' . g:ztl_default_slipbox_location), '\n')
  call s:open_popup_menu('zettels', i)
  " let id = popup_menu(i, #{ filter: 's:filter_handler', callback: 's:popup_close_callback_zettels' })
endfunc

func s:open_popup_menu(menu_kind, data)
  let l:menu_handler_name = 's:filter_handler_zettels'
  let l:menu_callback_name = 's:popup_close_callback_zettels'

  if a:menu_kind == 'references'
    let l:menu_handler_name = 's:filter_handler_references' 
    let l:menu_callback_name = 's:popup_close_callback_references'
  endif

  if a:menu_kind == 'tags'
    let l:menu_handler_name = 's:filter_handler' 
    let l:menu_callback_name = 's:popup_tags_close_callback'
  endif

  hi BorderColor  ctermfg=173

  " TODO: create a sort function and add it to sort()
  let id = popup_menu(sort(a:data), #{ 
	\ filter: l:menu_handler_name,
	\ callback: l:menu_callback_name,
	\ border: [],
	\ borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
	\ borderhighlight: ["BorderColor"],
	\ padding: [2, 8, 2, 8],
	\ title: a:menu_kind
	\ })
  return id
endfunc

func s:find_references()
  let i = split(system('ls ' . g:ztl_default_references_location), '\n')
  call s:open_popup_menu('references', i)
  " let id = popup_menu(i, #{ filter: 's:filter_handler', callback: 's:popup_close_callback_zettels' })
endfunc

func s:get_ztl_tags_list()
  let shell_return_cmd = split(system('cat ' . g:ztl_default_slipbox_location . '/*.ztl | grep "#\S\+" | sort | uniq -c'))
  let l:tags_list = []
  let l:count = 0
  let l:temp = []

  for i in shell_return_cmd
    if l:count == 0 
      call add(l:temp, i)
      let l:count = 1
    elseif l:count == 1
      call add(l:temp, i)
      call add(l:tags_list, join(l:temp))
      let l:temp = []
      let l:count = 0
    endif
  endfor

  return l:tags_list
endfunc

func s:find_tags()
  let l:tags_list = s:get_ztl_tags_list()
  " let id = popup_menu(l:tags_list, #{ filter: 's:filter_handler', callback: 's:popup_tags_close_callback' })
  call s:open_popup_menu('tags', l:tags_list)
endfunc

nnoremap ,zfz :call <SID>find_zettels()<CR>
nnoremap ,zfr :call <SID>find_references()<CR>
nnoremap ,zft :call <SID>find_tags()<CR>
nnoremap ,zh :-1read $HOME/.vim/bundle/vim-zettelkasten/snippets/ztl-metadata.ztl<cr>2jA
nnoremap ,zr :-1read $HOME/.vim/bundle/vim-zettelkasten/snippets/ztl-refs.ztl<CR>jA
nnoremap ,zt :! node $HOME/.vim/bundle/vim-zettelkasten/scripts/ztl_timestamp.js > $HOME/.vim/bundle/vim-zettelkasten/scripts/timestamp.txt<CR>$:read $HOME/.vim/bundle/vim-zettelkasten/scripts/timestamp.txt<CR>d$k$pjddk
