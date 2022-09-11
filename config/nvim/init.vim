filetype plugin indent on
syntax manual
colorscheme tired

"-----------------------" SETTINGS
set hidden
set showmode
set splitbelow
set splitright
set scrolloff=10
set termguicolors
set lazyredraw
set listchars=eol:$,tab:>-<,space:·
set ignorecase
set timeoutlen=500
set pyxversion=3
set undofile
set undolevels=100
set smartcase
set mouse=nv
set number
set relativenumber
set fillchars=fold:\ 
set foldcolumn=auto:4
set foldminlines=4
set foldnestmax=4
set foldtext=getline(v:foldstart).'\ ['.(v:foldend-v:foldstart+1).']\ '.trim(getline(v:foldend))
set signcolumn=yes
set tabstop=4
set shiftwidth=4
set expandtab
set statusline=[#%n]%y%q%m%r%h%w\ %c%V:%l-%L\ %<%f
set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m

if $BAT_THEME == 'gruvbox-light'
    set background=light
else
    set background=dark
endif

"-----------------------" MAPPINGS
let mapleader = ' '

nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

cnoremap <M-h> <Left>
cnoremap <M-S-h> <S-Left>
cnoremap <M-l> <Right>
cnoremap <M-S-l> <S-Right>
cnoremap <M-j> <Down>
cnoremap <M-k> <Up>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :nohlsearch<CR>
nnoremap <Leader>6 <C-^>

nnoremap <Leader>y "*Y
vnoremap <Leader>y "*y
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p
nnoremap <Leader>P "*P
vnoremap <Leader>P "*P

nnoremap <Leader>vi :edit $MYVIMRC<CR>
nnoremap <Leader>vs :source %<CR>
nnoremap <Leader>vu :lua usr.sync_plugins()<CR>
nnoremap <Leader>vt :TSEnable highlight<CR>

nnoremap [ob :set background=light<CR>
nnoremap ]ob :set background=dark<CR>
nnoremap [ol :set list<CR>
nnoremap ]ol :set nolist<CR>

nnoremap [a :previous<CR>
nnoremap ]a :next<CR>
nnoremap [A :first<CR>
nnoremap ]A :last<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>
nnoremap [L :lfirst<CR>
nnoremap ]L :llast<CR>
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap [t :tprevious<CR>
nnoremap ]t :tnext<CR>
nnoremap [T :tfirst<CR>
nnoremap ]T :tlast<CR>

"-----------------------" PLUGINS
lua require('setup')

