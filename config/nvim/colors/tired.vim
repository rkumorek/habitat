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
let s:none = ['NONE', 'NONE']
let s:dark0 = ['#282828', 235]          " 40-40-40
let s:dark1 = ['#3c3836', 237]          " 60-56-54
let s:dark2 = ['#504945', 239]          " 80-73-69
let s:dark3 = ['#665c54', 241]          " 102-92-84
let s:dark4 = ['#7c6f64', 243]          " 124-111-100
let s:dark4_256 = ['#7c6f64', 243]      " 124-111-100

let s:gray_245 =     ['#928374', 245]     " 146-131-116
let s:gray_244 =     ['#928374', 244]     " 146-131-116

let s:light0 =       ['#fbf1c7', 229]     " 253-244-193
let s:light1 =       ['#ebdbb2', 223]     " 235-219-178
let s:light2 =       ['#d5c4a1', 250]     " 213-196-161
let s:light3 =       ['#bdae93', 248]     " 189-174-147
let s:light4 =       ['#a89984', 246]     " 168-153-132
let s:light4_256 =   ['#a89984', 246]     " 168-153-132

let s:bright_red =      ['#fb4934', 167]     " 251-73-52
let s:bright_green =    ['#b8bb26', 142]     " 184-187-38
let s:bright_yellow =   ['#fabd2f', 214]     " 250-189-47
let s:bright_blue =     ['#83a598', 109]     " 131-165-152
let s:bright_purple =   ['#d3869b', 175]     " 211-134-155
let s:bright_aqua =     ['#8ec07c', 108]     " 142-192-124
let s:bright_orange =   ['#fe8019', 208]     " 254-128-25

let s:neutral_red =     ['#cc241d', 124]     " 204-36-29
let s:neutral_green =   ['#98971a', 106]     " 152-151-26
let s:neutral_yellow =  ['#d79921', 172]     " 215-153-33
let s:neutral_blue =    ['#458588', 66]      " 69-133-136
let s:neutral_purple =  ['#b16286', 132]     " 177-98-134
let s:neutral_aqua =    ['#689d6a', 72]      " 104-157-106
let s:neutral_orange =  ['#d65d0e', 166]     " 214-93-14

let s:faded_red =       ['#9d0006', 88]      " 157-0-6
let s:faded_green =     ['#79740e', 100]     " 121-116-14
let s:faded_yellow =    ['#b57614', 136]     " 181-118-20
let s:faded_blue =      ['#076678', 24]      " 7-102-120
let s:faded_purple =    ['#8f3f71', 96]      " 143-63-113
let s:faded_aqua =      ['#427b58', 65]      " 66-123-88
let s:faded_orange =    ['#af3a03', 130]     " 175-58-3

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
call s:Highlight('TabLineSel', s:none, s:bg1, 'NONE')
call s:Highlight('TabLine', s:fg3, s:none, 'NONE')
call s:Highlight('MatchParen', s:blue, s:bg1, 'underline,bold')
call s:Highlight('Conceal', s:blue, s:purple, 'NONE')
call s:Highlight('NonText', s:gray, s:none, 'NONE')
call s:Highlight('SpecialKey', s:none, s:none, 'bold')
call s:Highlight('Visual', s:none, s:bg2, 'NONE')
call s:Link('VisualNOS', 'Visual')
call s:Highlight('Search', s:bg0, s:fg3, 'NONE')
call s:Highlight('IncSearch', s:bg0, s:fg4, 'NONE')
call s:Highlight('QuickFixLine', s:none, s:bg1, 'NONE')
call s:Highlight('StatusLine', s:bg0, s:fg4, 'NONE')
call s:Highlight('StatusLineNC', s:fg4, s:bg2, 'NONE')
call s:Highlight('VertSplit', s:bg3, s:bg0, 'NONE')
call s:Highlight('WildMenu', s:none, s:purple, 'NONE')
call s:Clear('Directory') " ex. directory in NETRW
call s:Highlight('Title', s:fg0, s:none, 'NONE')
call s:Highlight('ErrorMsg', s:orange, s:none, 'bold')
call s:Clear('MoreMsg')
call s:Clear('ModeMsg')
call s:Clear('Question')
call s:Highlight('WarningMsg', s:orange, s:none, 'NONE')
call s:Clear('Identifier')
call s:Clear('PreProc')

" }}}
" Spelling: {{{

" TODO: Add highlighting
call s:Clear('SpellBad')
call s:Clear('SpellCap')
call s:Clear('SpellLocal')
call s:Clear('SpellRare')

" }}}
" Gutter: {{{

call s:Clear('LineNr')
call s:Clear('SignColumn')
call s:Highlight('Folded', s:none, s:bg1, 'NONE')
call s:Clear('FoldColumn')

" }}}
" Syntax Highlighting: {{{

call s:Clear('Special')
call s:Highlight('Comment', s:fg3, s:none, 'italic')
call s:Clear('Todo')
call s:Highlight('Error', s:orange, s:none, 'bold')
call s:Clear('Statement')
call s:Clear('Constant')
call s:Clear('Type')

" }}}
" Completion Menu: {{{

call s:Highlight('Pmenu', s:none, s:bg1, 'NONE')
call s:Highlight('PmenuSel', s:none, s:bg3, 'NONE')
call s:Highlight('PmenuSbar', s:none, s:bg2, 'NONE')
call s:Highlight('PmenuThumb', s:none, s:bg4, 'NONE')

" }}}
" Diffs: {{{

call s:Highlight('DiffAdd',    s:green, s:none, 'NONE')
call s:Highlight('DiffChange', s:aqua, s:none, 'NONE')
call s:Highlight('DiffDelete', s:red, s:none, 'NONE')
call s:Highlight('DiffText',   s:yellow, s:none, 'NONE')

" }}}
" LSP: {{{

call s:Highlight('DiagnosticError', s:orange, s:none, 'bold')
call s:Highlight('DiagnosticUnderlineError', s:orange, s:none, 'bold,underline')

call s:Highlight('DiagnosticWarn', s:orange, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineWarn', s:orange, s:none, 'underline')

call s:Clear('DiagnosticInfo')
call s:Highlight('DiagnosticUnderlineInfo', s:none, s:none, 'underline')

call s:Clear('DiagnosticHint')
call s:Highlight('DiagnosticUnderlineHint', s:none, s:none, 'underline')

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
call s:Link('TelescopeMultiSelection', 'Visual')

" }}}
" Fugitive: {{{

call s:Highlight('fugitiveHeader', s:none, s:none, 'bold')
call s:Highlight('fugitiveUntrackedHeading', s:none, s:none, 'bold')
call s:Highlight('fugitiveUnstagedHeading', s:none, s:none, 'bold')

" }}}
 
" FILETYPES
" Diff: {{{

call s:Highlight('diffAdded', s:green, s:none, 'NONE')
call s:Highlight('diffRemoved', s:red, s:none, 'NONE')
call s:Highlight('diffChanged', s:aqua, s:none, 'NONE')
call s:Highlight('diffLine', s:none, s:bg1, 'NONE')

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
