" vim: sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
"
" Gruvbox https://github.com/morhetz/gruvbox theme but with less colours.
"
" Does not follow best practices mentioned in vim repository:
" https://github.com/vim/vim/blob/master/runtime/colors/README.txt
"
" Expected Gruvbox terminal colors.
"
" │ Index │ Dark Theme Value  │ Light Theme Value │ Note
" │ 0     │ #282828           │ #fbf1c7           │ Background (Bg0)
" │ 1     │ #cc241d           │ #cc241d           │ Red
" │ 2     │ #98971a           │ #98971a           │ Green
" │ 3     │ #d79921           │ #d79921           │ Yellow
" │ 4     │ #458588           │ #458588           │ Blue
" │ 5     │ #b16286           │ #b16286           │ Purple
" │ 6     │ #689d6a           │ #689d6a           │ Aqua
" │ 7     │ #a89984           │ #7c6f64           │ Alt Foreground
" │ 8     │ #3c3836           │ #ebdbb2           │ Alt Background (Bg1)
" │ 9     │ #fb4934           │ #9d0006           │ Alt Red
" │ 10    │ #b8bb26           │ #79740e           │ Alt Green
" │ 11    │ #fabd2f           │ #b57614           │ Alt Yellow
" │ 12    │ #83a598           │ #076678           │ Alt Blue
" │ 13    │ #d3869b           │ #8f3f71           │ Alt Purple
" │ 14    │ #8ec07c           │ #427b58           │ Alt Aqua
" │ 15    │ #fbf1c7           │ #282828           │ Foreground
" │ __    │ _______           │ _______           │ __________
" │ 166   │ #d65d0e           │ #d65d0e           │ Orange
"
" Default colors stay the same on both themes.
" Bright (alt) colors are darker on light theme and brigter on dark theme.
"
" Use :highlight to preview theme.

" Initialisation: {{{

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name='tired'

" }}}
" Palette: {{{

let s:none        = 'NONE'
let s:bg          = 0
let s:red         = 1
let s:green       = 2
let s:yellow      = 3
let s:blue        = 4
let s:purple      = 5
let s:aqua        = 6
let s:a_fg        = 7
let s:a_bg        = 8
let s:a_red       = 9
let s:a_green     = 10
let s:a_yellow    = 11
let s:a_blue      = 12
let s:a_purple    = 13
let s:a_aqua      = 14
let s:fg          = 15
let s:orange      = 166
let s:guisp_yellow  = '#d79920'
let s:guisp_red     = '#cc241d'
let s:guisp_gray    = '#928374'
let s:guisp_blue    = '#458588'
let s:guisp_fg      = 'fg'

" }}}
" Helper functions: {{{

function! s:Clear(group)
  execute 'highlight! clear ' . a:group
  execute 'highlight ' . a:group . ' NONE'
endfunction

function! s:Highlight(group, fg, bg, style, ...)
  " Parameters: group, guifg, guibg, gui, guisp
  call s:Clear(a:group)

  let l:hi_expr = 'highlight ' . a:group
  let l:hi_expr .= ' cterm=' . a:style
  let l:hi_expr .= ' ctermfg=' . a:fg
  let l:hi_expr .= ' ctermbg=' . a:bg
  let l:hi_expr .= ' gui=' . a:style

  if a:0 > 0
    let l:hi_expr .= ' guisp=' . a:1
  endif

  execute l:hi_expr
endfunction

function! s:Link(from, to)
  call s:Clear(a:from)
  execute 'highlight link ' . a:from . ' ' . a:to
endfunction

" }}}
" UI: {{{

call s:Highlight('Normal', s:fg, s:none, 'NONE')
call s:Highlight('Underlined', s:none, s:none, 'underline')

call s:Highlight('ColorColumn', s:none, s:a_bg, 'NONE')
call s:Highlight('CursorColumn', s:none, s:a_bg, 'NONE')
call s:Highlight('CursorLine', s:none, s:a_bg, 'NONE')
call s:Clear('CursorLineNr')

call s:Highlight('FloatBorder', s:a_fg, s:none, 'NONE')
call s:Clear('TabLineFill')
call s:Highlight('TabLineSel', s:bg, s:green, 'bold')
call s:Highlight('TabLine', s:fg, s:none, 'NONE')
call s:Highlight('MatchParen', s:none, s:none, 'inverse')
" Eye catching display so that I can locate where it is used.
call s:Highlight('Conceal', s:blue, s:purple, 'NONE')
call s:Highlight('NonText', s:a_fg, s:none, 'NONE')
call s:Highlight('SpecialKey', s:a_purple, s:none, 'bold')
call s:Highlight('Visual', s:bg, s:fg, 'NONE')
call s:Link('VisualNOS', 'Visual')
call s:Highlight('Search', s:bg, s:aqua, 'NONE')
call s:Highlight('IncSearch', s:bg, s:blue, 'NONE')
call s:Highlight('QuickFixLine', s:none, s:a_bg, 'bold')
call s:Highlight('StatusLine', s:bg, s:a_fg, 'NONE')
call s:Highlight('StatusLineNC', s:none, s:a_bg, 'NONE')
call s:Highlight('VertSplit', s:a_bg, s:none, 'NONE')
" Usually popup-menu is displayed. See 'wildoptions'.
call s:Clear('WildMenu')
call s:Highlight('Directory', s:aqua, s:none, 'bold') " ex. directory in NETRW
call s:Highlight('Title', s:none, s:none, 'bold')
call s:Highlight('ErrorMsg', s:red, s:none, 'bold')
call s:Highlight('MoreMsg', s:none, s:none, 'bold')
call s:Clear('ModeMsg')
call s:Clear('Question')
call s:Highlight('WarningMsg', s:yellow, s:none, 'bold')

" }}} 
" Spelling: {{{

call s:Highlight('SpellBad', s:none, s:none, 'underdotted', s:guisp_red)
call s:Highlight('SpellCap', s:none, s:none, 'underdotted', s:guisp_gray)
call s:Highlight('SpellLocal', s:none, s:none, 'underdotted', s:guisp_gray)
call s:Highlight('SpellRare', s:none, s:none, 'underdotted', s:guisp_blue)

" }}}
" Gutter: {{{

call s:Highlight('LineNr', s:a_fg, s:none, 'NONE')
call s:Clear('SignColumn')
call s:Highlight('Folded', s:none, s:a_bg, 'NONE')
call s:Clear('FoldColumn')

" }}}
" Syntax Highlighting: {{{

" Neovim HL init:
" https://github.com/neovim/neovim/blob/2f385d17a027d132bf2308dd5b1b0c8ce862e761/src/nvim/highlight_group.c#L104
"
" nvim-treesitter highlight groups:
" https://github.com/nvim-treesitter/nvim-treesitter/blob/557123a6168936983d7b980df195057ca6b370ed/lua/nvim-treesitter/highlight.lua#L190-L270

" hi Type            ctermfg=4
" hi Keyword         ctermfg=2
" hi Function        ctermfg=4
" hi Identifier      ctermfg=7   cterm=NONE
" hi Statement       ctermfg=1   cterm=bold
" hi Constant        ctermfg=13
" hi Number          ctermfg=12
" hi Boolean         ctermfg=4
" hi Special         ctermfg=13
call s:Link('Boolean', 'Number')
call s:Link('Character', 'String')
call s:Highlight('Comment', s:a_yellow, s:none, 'italic')
call s:Link('Conditional', 'Normal')
call s:Link('Constant', 'Normal')
call s:Link('Debug', 'Normal')
call s:Link('Define', 'Normal')
call s:Link('Delimiter', 'Normal')
call s:Highlight('Error', s:none, s:none, 'underdashed', s:guisp_red) " hl-TSError links here
call s:Link('Exception', 'Normal')
call s:Link('Float', 'Number')
call s:Link('Function', 'Normal')
call s:Link('Identifier', 'Normal')
call s:Link('Include', 'Normal')
call s:Highlight('Keyword', s:a_blue, s:none, 'NONE')
call s:Link('Label', 'Normal')
call s:Link('Macro', 'Normal')
call s:Highlight('Number', s:a_blue, s:none, 'NONE')
call s:Link('Operator', 'Normal')
call s:Link('PreProc', 'Normal')
call s:Link('Repeat', 'Normal')
call s:Link('Special', 'Normal')
call s:Highlight('SpecialChar', s:purple, s:none, 'NONE')
call s:Link('SpecialComment', 'Comment') " It is not currently used in nvim-treesitter queries.
call s:Link('Statement', 'Normal')
call s:Link('StorageClass', 'Normal')
call s:Highlight('String', s:a_aqua, s:none, 'NONE')
call s:Link('Todo', 'Normal')
call s:Link('Type', 'Normal')
call s:Link('Typedef', 'Normal')

" }}}
" Completion Menu: {{{

call s:Highlight('Pmenu', s:none, s:none, 'NONE')
call s:Highlight('PmenuSel', s:none, s:a_bg, 'NONE') 
call s:Highlight('PmenuSbar', s:none, s:a_bg, 'NONE')
call s:Highlight('PmenuThumb', s:none, s:fg, 'NONE')

" }}}
" LSP: {{{

call s:Highlight('DiagnosticError', s:red, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineError', s:none, s:none, 'undercurl', s:guisp_red)

call s:Highlight('DiagnosticWarn', s:yellow, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineWarn', s:none, s:none, 'undercurl', s:guisp_yellow)

call s:Highlight('DiagnosticInfo', s:blue, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineInfo', s:none, s:none, 'undercurl', s:guisp_blue)

call s:Highlight('DiagnosticHint', s:fg, s:none, 'NONE')
call s:Highlight('DiagnosticUnderlineHint', s:none, s:none, 'undercurl', s:guisp_gray)

call s:Highlight('DiagnosticUnnecessary', s:a_fg, s:none, 'underline')

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

call s:Highlight('DirvishPathTail', s:aqua, s:none, 'bold')
call s:Highlight('DirvishSuffix', s:green, s:none, 'NONE')
call s:Highlight('DirvishArg', s:yellow, s:none, 'NONE')

" }}}
" Telescope.nvim: {{{

call s:Highlight('TelescopeSelection', s:none, s:a_bg, 'NONE')
call s:Highlight('TelescopeMatching', s:none, s:none, 'bold,underline', s:guisp_fg)
call s:Highlight('TelescopeMultiSelection', s:a_aqua, s:none, 'bold')

" }}}
" Fugitive: {{{

call s:Highlight('fugitiveHeader', s:none, s:none, 'bold')
call s:Highlight('fugitiveUntrackedHeading', s:none, s:none, 'bold')
call s:Highlight('fugitiveUnstagedHeading', s:none, s:none, 'bold')

" }}}
 
" FILETYPES
" Diff: {{{

call s:Highlight('DiffAdd', s:green, s:none, 'NONE')
call s:Highlight('DiffDelete', s:red, s:none, 'NONE')
call s:Highlight('DiffChange', s:none, s:none, 'NONE')
call s:Highlight('DiffText', s:a_green, s:none, 'NONE')

call s:Highlight('diffAdded', s:a_green, s:none, 'NONE')
call s:Highlight('diffRemoved', s:a_red, s:none, 'NONE')
call s:Highlight('diffChanged', s:blue, s:none, 'NONE')
call s:Highlight('diffLine', s:a_green, s:a_bg, 'bold')
call s:Highlight('diffSubname', s:none, s:a_bg, 'bold')

" }}}
" Markdown: {{{

call s:Highlight('markdownItalic', s:none, s:none, 'italic')
call s:Highlight('markdownBold', s:none, s:none, 'bold')
call s:Highlight('markdownBoldItalic', s:none, s:none, 'bold,italic')
call s:Highlight('markdownLinkText', s:none, s:none, 'NONE')

" }}}
" Git: {{{

call s:Highlight('gitKeyword', s:none, s:none, 'bold')
call s:Highlight('gitHash', s:a_green, s:none, 'NONE')
call s:Highlight('gitIdentityKeyword', s:none, s:none, 'bold')

" }}}
