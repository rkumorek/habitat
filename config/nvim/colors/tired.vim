" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:

" Initialisation: {{{

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name='tired'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Palette: {{{
let s:none =            ['NONE', 'NONE']
let s:dark0 =           ['#282828', 235] " 40-40-40
let s:dark1 =           ['#3C3836', 237] " 60-56-54
let s:dark2 =           ['#504945', 239] " 80-73-69
let s:dark3 =           ['#665C54', 241] " 102-92-84
let s:dark4 =           ['#7C6F64', 243] " 124-111-100
let s:dark4_256 =       ['#7C6F64', 243] " 124-111-100

let s:gray_245 =        ['#928374', 245] " 146-131-116
let s:gray_244 =        ['#928374', 244] " 146-131-116

let s:light0 =          ['#FBF1C7', 229] " 253-244-193
let s:light1 =          ['#EBDBB2', 223] " 235-219-178
let s:light2 =          ['#D5C4A1', 250] " 213-196-161
let s:light3 =          ['#BDAE93', 248] " 189-174-147
let s:light4 =          ['#A89984', 246] " 168-153-132
let s:light4_256 =      ['#A89984', 246] " 168-153-132

let s:bright_red =      ['#FB4934', 167] " 251-73-52
let s:bright_green =    ['#B8BB26', 142] " 184-187-38
let s:bright_yellow =   ['#FABD2F', 214] " 250-189-47
let s:bright_blue =     ['#83A598', 109] " 131-165-152
let s:bright_purple =   ['#D3869B', 175] " 211-134-155
let s:bright_aqua =     ['#8EC07C', 108] " 142-192-124
let s:bright_orange =   ['#FE8019', 208] " 254-128-25

let s:faded_red =       ['#9D0006', 88]  " 157-0-6
let s:faded_green =     ['#79740E', 100] " 121-116-14
let s:faded_yellow =    ['#B57614', 136] " 181-118-20
let s:faded_blue =      ['#076678', 24]  " 7-102-120
let s:faded_purple =    ['#8F3F71', 96]  " 143-63-113
let s:faded_aqua =      ['#427B58', 65]  " 66-123-88
let s:faded_orange =    ['#AF3A03', 130] " 175-58-3

let s:diff_add_dark =       ['#3E4F37', 28]
let s:diff_change_dark =    ['#274F4A', 44]
let s:diff_remove_dark =    ['#4F2F2F', 33]

let s:diff_add_bright =     ['#CDE3BE', 37]
let s:diff_change_bright =  ['#D3E3DF', 21]
let s:diff_remove_bright =  ['#E7C9C6', 36]

let s:brown_dark =    ['#755000', 33]
let s:brown_bright =  ['#E1C798', 43]
let s:accent_dark =   ['#034F4E', 36]
let s:accent_bright = ['#FFE8A3', 29]

if (&background == 'dark')
  let s:bg0  = s:dark0
  let s:bg1  = s:dark1
  let s:bg2  = s:dark2
  let s:bg3  = s:dark3
  let s:bg4  = s:dark4

  let s:gray = s:gray_245

  let s:fg0 = s:light0
  let s:fg1 = s:light1
  let s:fg2 = s:light2
  let s:fg3 = s:light3
  let s:fg4 = s:light4

  let s:fg4_256 = s:light4_256

  let s:red    = s:bright_red
  let s:green  = s:bright_green
  let s:yellow = s:bright_yellow
  let s:blue   = s:bright_blue
  let s:purple = s:bright_purple
  let s:aqua   = s:bright_aqua
  let s:orange = s:bright_orange

  let s:brown = s:brown_bright
  let s:accent = s:accent_bright

  let s:diff_add = s:diff_add_dark
  let s:diff_remove = s:diff_remove_dark
  let s:diff_change = s:diff_change_dark
else
  let s:bg0  = s:light0
  let s:bg1  = s:light1
  let s:bg2  = s:light2
  let s:bg3  = s:light3
  let s:bg4  = s:light4

  let s:gray = s:gray_244

  let s:fg0 = s:dark0
  let s:fg1 = s:dark1
  let s:fg2 = s:dark2
  let s:fg3 = s:dark3
  let s:fg4 = s:dark4

  let s:fg4_256 = s:dark4_256

  let s:red    = s:faded_red
  let s:green  = s:faded_green
  let s:yellow = s:faded_yellow
  let s:blue   = s:faded_blue
  let s:purple = s:faded_purple
  let s:aqua   = s:faded_aqua
  let s:orange = s:faded_orange

  let s:brown = s:brown_dark
  let s:accent = s:accent_dark

  let s:diff_add = s:diff_add_bright
  let s:diff_remove = s:diff_remove_bright
  let s:diff_change = s:diff_change_bright
endif
" }}}
" Helper functions: {{{
function! s:Clear(group)
  execute 'highlight! clear ' . a:group
  execute 'highlight ' . a:group . ' NONE'
endfunction

function! s:Highlight(group, fg, bg, style, ...)
  " Parameters: group, guifg, guibg, gui, guisp
  call s:Clear(a:group)

  let l:guifg = a:fg[0]
  let l:ctermfg = a:fg[1]
  let l:guibg = a:bg[0]
  let l:ctermbg = a:bg[1]

  let l:hi_expr = 'highlight ' . a:group
  let l:hi_expr .= ' cterm=' . a:style
  let l:hi_expr .= ' ctermfg=' . l:ctermfg
  let l:hi_expr .= ' ctermbg=' . l:ctermbg
  let l:hi_expr .= ' gui=' . a:style
  let l:hi_expr .= ' guifg=' . l:guifg
  let l:hi_expr .= ' guibg=' . l:guibg

  if a:0 > 0
    let l:hi_expr .= ' guisp=' . a:1[0]
  endif

  execute l:hi_expr
endfunction

function! s:Link(from, to)
  call s:Clear(a:from)
  execute 'highlight link ' . a:from . ' ' . a:to
endfunction

" }}}
" UI: {{{

call s:Highlight('Normal', s:fg0, s:bg0, 'NONE')
call s:Highlight('Underlined', s:none, s:none, 'underline')

call s:Highlight('ColorColumn', s:none, s:bg1, 'NONE')
call s:Highlight('CursorColumn', s:none, s:bg1, 'NONE')
call s:Highlight('CursorLine', s:none, s:bg1, 'NONE')
call s:Clear('CursorLineNr')

call s:Clear('TabLineFill')
call s:Highlight('TabLineSel', s:none, s:bg2, 'NONE')
call s:Highlight('TabLine', s:none, s:none, 'NONE')
call s:Highlight('MatchParen', s:bg0, s:fg4, 'bold')
" Eye catching display so that I can locate where it is used.
call s:Highlight('Conceal', s:blue, s:purple, 'NONE')
call s:Highlight('NonText', s:gray, s:none, 'NONE')
call s:Highlight('SpecialKey', s:none, s:none, 'bold')
call s:Highlight('Visual', s:none, s:bg2, 'NONE')
call s:Link('VisualNOS', 'Visual')
call s:Highlight('Search', s:bg0, s:fg4, 'NONE')
call s:Highlight('IncSearch', s:bg0, s:fg1, 'NONE')
call s:Highlight('QuickFixLine', s:none, s:bg1, 'NONE')
call s:Highlight('StatusLine', s:bg0, s:fg4, 'NONE')
call s:Highlight('StatusLineNC', s:fg4, s:bg2, 'NONE')
call s:Highlight('VertSplit', s:bg3, s:bg0, 'NONE')
" Usually popup-menu is displayed. See 'wildoptions'.
call s:Clear('WildMenu')
call s:Clear('Directory') " ex. directory in NETRW
call s:Highlight('Title', s:none, s:none, 'bold')
call s:Highlight('ErrorMsg', s:red, s:none, 'bold')
call s:Highlight('MoreMsg', s:none, s:none, 'bold')
call s:Clear('ModeMsg')
call s:Clear('Question')
call s:Highlight('WarningMsg', s:yellow, s:none, 'bold')

" }}}
" Spelling: {{{

call s:Highlight('SpellBad', s:none, s:none, 'underdotted', s:red)
call s:Highlight('SpellCap', s:none, s:none, 'underdotted', s:gray)
call s:Highlight('SpellLocal', s:none, s:none, 'underdotted', s:gray)
call s:Highlight('SpellRare', s:none, s:none, 'underdotted', s:blue)

" }}}
" Gutter: {{{

call s:Clear('LineNr')
call s:Clear('SignColumn')
call s:Highlight('Folded', s:none, s:bg1, 'NONE')
call s:Clear('FoldColumn')

" }}}
" Syntax Highlighting: {{{

" Neovim HL init:
" https://github.com/neovim/neovim/blob/2f385d17a027d132bf2308dd5b1b0c8ce862e761/src/nvim/highlight_group.c#L104
"
" nvim-treesitter highlight groups:
" https://github.com/nvim-treesitter/nvim-treesitter/blob/557123a6168936983d7b980df195057ca6b370ed/lua/nvim-treesitter/highlight.lua#L190-L270

call s:Clear('Boolean')
call s:Clear('Character')
call s:Highlight('Comment', s:brown, s:none, 'italic')
call s:Clear('Conditional')
call s:Clear('Constant')
call s:Clear('Debug')
call s:Clear('Define')
call s:Clear('Delimiter')
call s:Highlight('Error', s:none, s:none, 'underdashed', s:orange) " hl-TSError links here
call s:Clear('Exception')
call s:Clear('Float')
call s:Clear('Function')
call s:Clear('Identifier')
call s:Clear('Include')
call s:Clear('Keyword')
call s:Clear('Label')
call s:Clear('Macro')
call s:Clear('Number')
call s:Clear('Operator')
call s:Clear('PreProc')
call s:Clear('Repeat')
call s:Clear('Special')
call s:Highlight('SpecialChar', s:purple, s:none, 'NONE')
call s:Link('SpecialComment', 'Comment') " It is not currently used in nvim-treesitter queries.
call s:Clear('Statement')
call s:Clear('StorageClass')
call s:Highlight('String', s:accent, s:none, 'NONE')
call s:Clear('Todo')
call s:Clear('Type')
call s:Clear('Typedef')

" }}}
" Completion Menu: {{{

call s:Highlight('Pmenu', s:none, s:bg1, 'NONE')
call s:Highlight('PmenuSel', s:none, s:bg3, 'NONE')
call s:Highlight('PmenuSbar', s:none, s:bg2, 'NONE')
call s:Highlight('PmenuThumb', s:none, s:bg4, 'NONE')

" }}}
" LSP: {{{

call s:Highlight('DiagnosticError', s:red, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineError', s:none, s:none, 'undercurl', s:red)

call s:Highlight('DiagnosticWarn', s:yellow, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineWarn', s:none, s:none, 'undercurl', s:yellow)

call s:Highlight('DiagnosticInfo', s:blue, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineInfo', s:none, s:none, 'undercurl', s:blue)

call s:Highlight('DiagnosticHint', s:fg3, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineHint', s:none, s:none, 'undercurl')

" TODO: add the following 
" LspReferenceText
" LspReferenceRead
" LspReferenceWrite
" LspCodeLens
" LspCodeLensSeparator
" LspSignatureActiveParameter

" }}}

" PLUGINS
" Dirvish: {{{

call s:Highlight('DirvishPathTail', s:aqua, s:none, 'NONE')
call s:Highlight('DirvishArg', s:yellow, s:none, 'NONE')

" }}}
" Telescope.nvim: {{{

call s:Highlight('TelescopeMatching', s:none, s:none, 'bold')
call s:Highlight('TelescopeMultiSelection', s:aqua, s:none, 'bold')
call s:Highlight('TelescopeMultiIcon', s:none, s:none, 'bold')

" }}}
" Fugitive: {{{

call s:Highlight('fugitiveHeader', s:none, s:none, 'bold')
call s:Highlight('fugitiveUntrackedHeading', s:none, s:none, 'bold')
call s:Highlight('fugitiveUnstagedHeading', s:none, s:none, 'bold')

" }}}
 
" FILETYPES
" Diff: {{{

call s:Highlight('DiffAdd', s:none, s:diff_add, 'NONE')
call s:Highlight('DiffDelete', s:none, s:diff_remove, 'NONE')
call s:Highlight('DiffChange', s:none, s:bg1, 'NONE')
call s:Highlight('DiffText', s:none, s:diff_change, 'NONE')

call s:Highlight('diffAdded', s:none, s:diff_add, 'NONE')
call s:Highlight('diffRemoved', s:none, s:diff_remove, 'NONE')
call s:Highlight('diffChanged', s:none, s:diff_change, 'NONE')
call s:Highlight('diffLine', s:brown, s:bg1, 'bold')
call s:Highlight('diffSubname', s:none, s:bg1, 'NONE')

" }}}
" Markdown: {{{

call s:Highlight('markdownItalic', s:none, s:none, 'italic')
call s:Highlight('markdownBold', s:none, s:none, 'bold')
call s:Highlight('markdownBoldItalic', s:none, s:none, 'bold,italic')
call s:Highlight('markdownLinkText', s:none, s:none, 'NONE')

" }}}
" Git: {{{

call s:Highlight('gitKeyword', s:none, s:none, 'bold')
call s:Highlight('gitIdentityKeyword', s:none, s:none, 'bold')

" }}}
