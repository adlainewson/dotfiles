" TrueColors
if (has("termguicolors"))
  set termguicolors
endif
""""""" Vim-plug for vim plugin installs
call plug#begin('~/.vim/vimplug')
Plug 'kaicataldo/material.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

" au BufRead,BufNewFile *.jl set filetype=julia
set guioptions-=T  "Remove toolbar
set expandtab "Expand tabs into spaces
" Stop highlighting red in fortran tabs
hi link fortranTab NONE 
set shiftwidth=3
if has("gui_running")
  " GUI is running or is about to start.              
  set lines=43 columns=75
  colorscheme evening
endif
set history=1000
set undolevels=1000
set wildmode=list:longest
syntax on
set autoindent
filetype plugin indent on
   " smartindent not used anymore. See http://stackoverflow.com/questions/18415492/autoindent-is-subset-of-smartindent-in-vim/18415867#18415867 and this 'feature': http://stackoverflow.com/questions/2063175/comments-go-to-start-of-line-in-the-insert-mode-in-vim
   " set smartindent 
inoremap # X#
set formatoptions=1
set lbr
" Mapping Ctrl-Backspace as Ctrl-W (doesn't work in terminal :()
imap <C-BS> <C-W>
" This maps Ctrl-a to select all; but it conflicts with increment number
" nmap <C-a> ggVG<CR>
set showbreak=\ \ \ \ \ ... 
" set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
highlight Normal ctermbg=black
set mousemodel=popup
" Search highlighting:
set hlsearch
nnoremap <CR> :nohlsearch<CR><CR>
" colorscheme zellner
" colorscheme jellybeans
"Material theme
"let g:material_theme_style = 'default' | 'palenight' | 'dark'
colorscheme material
let g:material_theme_style = 'dark'
set background=dark

" Split options
set splitbelow
set splitright

"" Search highlighting:
"highlight Search cterm=NONE ctermfg=white ctermbg=DarkBlue 

" Temp file saving
nnoremap zz :update<cr>
vnoremap zs :w! tmp.do<cr>
vnoremap zj :w! tmp.jl<cr>

" Remap split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Visual navigation
nnoremap k gk
nnoremap j gj
nnoremap 0 g0
nnoremap $ g$
nnoremap ^ g^


