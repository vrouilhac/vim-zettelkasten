" Vim syntax for zettelkasten workflow
" Maintainer    : Vincent Rouilhac
" Last update   : 2021 Jan 11 <vincentrouilhac.com>

if exists("b:current_syntax")
  finish
endif
let b:current_syntax="vim-zettelkasten"

syn keyword zettelkastenReferences References

syn match zettelkastenArchiveLink '[[:space:]]@*a_[a-z0-9]\+'
syn match zettelkastenReferenceLink '[[:space:]]@*r_[a-z0-9]\+'

syn region zettelkastenMetadata start='---' end='---' contains=zettelkastenArchiveLink,zettelkastenReferenceLink
syn region zettelkastenWebLink start='\[\[' end='\]\]'

hi def link zettelkastenReferences    References
hi def link zettelkastenArchiveLink   ArchiveLink
hi def link zettelkastenReferenceLink ReferenceLink
hi def link zettelkastenMetadata      Metadata
hi def link zettelkastenWebLink       WebLink

hi References ctermfg=94 cterm=bold
hi ArchiveLink ctermfg=75 cterm=bold
hi ReferenceLink ctermfg=72 cterm=bold 
hi Metadata ctermfg=59
hi WebLink ctermfg=219
