" TrueColors
if (has("termguicolors"))
  set termguicolors
endif

""""""" Vim-plug for vim plugin installs
call plug#begin('~/.vim/vimplug')
Plug 'kaicataldo/material.vim'
Plug 'vim-airline/vim-airline'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

" This disables Esc-codes. One such code begins Esc-O, which slows down the O command
set noesckeys
" au BufRead,BufNewFile *.jl set filetype=julia
set guioptions-=m  "Remove menubar
set guioptions-=T  "Remove toolbar
set guioptions-=r  "Remove scrollbar
if (has("gui_running"))
   set guifont=PragmataPro
endif
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
"" Mapping Ctrl-Backspace as Ctrl-W (doesn't work in terminal :()
"imap <C-BS> <C-W>

" This maps Ctrl-a to select all; but it conflicts with increment number
" nmap <C-a> ggVG<CR>
set showbreak=\ \ \ \ \ ... 
" set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
highlight Normal ctermbg=black
set mousemodel=popup
" Search highlighting:
set hlsearch
nnoremap <CR> :nohlsearch<CR>
" colorscheme zellner
" colorscheme jellybeans

"Material theme
""let g:material_theme_style = 'default' | 'palenight' | 'dark'
colorscheme material
let g:material_theme_style = 'dark'
set background=dark

" Split options
set splitbelow
set splitright

"" Search highlighting:
"highlight Search cterm=NONE ctermfg=white ctermbg=DarkBlue 

" Save file with sudo
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :edit! | :q

" Misc
nnoremap zz :update<cr>
nnoremap zo zz:!overleaf_pushmain<cr>
" Compile latex file main.tex
nnoremap zl :!pdflatex main.tex<cr>
" Temp file saving
vnoremap zs :w! tmp.do<cr>
vnoremap zj :w! tmp.jl<cr>
" Python save & execute section
vnoremap zp :w! tmp.py<cr>:!python tmp.py<cr>
" Compile latex file (if it's called main.tex)
" Copy and paste
vnoremap zP "+P
vnoremap zC "+y


" Disable comment continuation for all filetypes
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" Remap split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Visual navigation
vnoremap k gk
vnoremap j gj
vnoremap 0 g0
vnoremap $ g$
vnoremap ^ g^
nnoremap k gk
nnoremap j gj
nnoremap 0 g0
nnoremap $ g$
nnoremap ^ g^

" Move by paragraph
nnoremap J }z.
nnoremap K {z.
vnoremap J }
vnoremap K {

" Other navigation buttons; not sure if this conflicts with split navigation
nnoremap <C-j> J
"vnoremap <C-j> }
"vnoremap <C-k> {

" Determine if we're in a python virtualenv
"    probably best to disable this unless actively developing in python
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF


" Determine if we're in a python virtualenv
"    probably best to disable this unless actively developing in python
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF


" Blinking highlights
" Damian Conway's Die Blinkënmatchen: highlight matches
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

