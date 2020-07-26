if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "rcpe"

syn iskeyword A-Z,.
syn keyword rcpeKeywords .TITLE .DATE .PREPTIME .COOKTIME .SERVES .CATEGORY .SOURCE

syn keyword listKeywords .BEGIN .END nextgroup=listNames
syn keyword listNames INGREDIENTS STEPS
syn keyword listItems .INGREDIENT .STEP

hi def link listNames String
hi def link listItems Constant
hi def link rcpeKeywords Keyword
hi def link listKeywords Keyword
