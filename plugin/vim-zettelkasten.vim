" A Vim plugin that tries to put the Zettelkasten workflow's power right at your fingertips.
" 
" Last update : 2022 Feb 08
" Maintainer  : Vincent Rouilhac [vincentrouilhac.com ; vrouilhacpe@gmail.com]
" Version     : 1.0

" if exists(g:loaded_zettelkasten)
"   finish
" endif
" let g:loaded_zettelkasten = 1

" map <unique> <Leader>a <Plug>TypecorrAdd

nnoremap ,zh :-1read $HOME/.vim/bundle/vim-zettelkasten/snippets/ztl-metadata.ztl<cr>2jA
nnoremap ,zr :-1read $HOME/.vim/bundle/vim-zettelkasten/snippets/ztl-refs.ztl<CR>jA
nnoremap ,zt :! node $HOME/.vim/bundle/vim-zettelkasten/scripts/ztl_timestamp.js > $HOME/.vim/bundle/vim-zettelkasten/scripts/timestamp.txt<CR>$:read $HOME/.vim/bundle/vim-zettelkasten/scripts/timestamp.txt<CR>d$k$pjddk
