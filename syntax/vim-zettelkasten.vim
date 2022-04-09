" Vim syntax for zettelkasten workflow
" Maintainer    : Vincent Rouilhac
" Last update   : 2022 Jan 11 <vincentrouilhac.com>

if exists("b:current_syntax")
  finish
endif
let b:current_syntax="vim-zettelkasten"

syn keyword zettelkastenReferences References

syn match zettelkastenMetadataInfo ':[[:space:]].\+' contained
syn match zettelkastenArchiveLink '[[:space:]]@*a_[a-z0-9]\+'
syn match zettelkastenReferenceLink '[[:space:]]@*r_[a-z0-9]\+'
syn match zettelkastenTag '#\S\+'

syn region zettelkastenMetadata start='---' end='---' contains=zettelkastenMetadataInfo,zettelkastenArchiveLink,zettelkastenReferenceLink
syn region zettelkastenWebLink start='\[\[' end='\]\]'

hi def link zettelkastenReferences    References
hi def link zettelkastenMetadataInfo  MetadataInfo
hi def link zettelkastenArchiveLink   ArchiveLink
hi def link zettelkastenReferenceLink ReferenceLink
hi def link zettelkastenMetadata      Metadata
hi def link zettelkastenWebLink       WebLink
hi def link zettelkastenTag	      Tag

hi References ctermfg=94 cterm=bold
hi MetadataInfo ctermfg=75
hi ArchiveLink ctermfg=75 cterm=bold
hi ReferenceLink ctermfg=72 cterm=bold 
hi Metadata ctermfg=59
hi WebLink ctermfg=219
hi Tag ctermfg=242 cterm=bold 
