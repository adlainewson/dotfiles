"       _                       _             
"__   _(_)_ __ ___        _ __ | |_   _  __ _ 
"\ \ / / | '_ ` _ \ _____| '_ \| | | | |/ _` |
" \ V /| | | | | | |_____| |_) | | |_| | (_| |
"  \_/ |_|_| |_| |_|     | .__/|_|\__,_|\__, |
"                        |_|            |___/ 
" Check for existing install of vim-plug, install if not found
  if empty(glob('~/.vim/autoload/plug.vim'))
     silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  " Run PlugInstall if there are missing plugins
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif

  " Run PlugInstall if there are missing plugins
  call plug#begin('~/.vim/vimplug')
      Plug 'kaicataldo/material.vim'
      Plug 'vim-airline/vim-airline'
      Plug 'JuliaEditorSupport/julia-vim'
  call plug#end()
" end of VIM-PLUG

"
" ____       _   _   _                 
"/ ___|  ___| |_| |_(_)_ __   __ _ ___ 
"\___ \ / _ \ __| __| | '_ \ / _` / __|
" ___) |  __/ |_| |_| | | | | (_| \__ \
"|____/ \___|\__|\__|_|_| |_|\__, |___/
"                            |___/     
" This disables Esc-codes. One such code begins Esc-O, which slows down the O command
set noesckeys
" au BufRead,BufNewFile *.jl set filetype=julia
set expandtab "Expand tabs into spaces
" Stop highlighting red in fortran tabs
hi link fortranTab NONE 
set shiftwidth=3
set history=1000
set undolevels=1000
set wildmode=list:longest
syntax on
set autoindent
filetype plugin indent on
"" smartindent not used anymore. See http://stackoverflow.com/questions/18415492/autoindent-is-subset-of-smartindent-in-vim/18415867#18415867 and this 'feature': http://stackoverflow.com/questions/2063175/comments-go-to-start-of-line-in-the-insert-mode-in-vim
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

" Split options
set splitbelow
set splitright

" Auto set linewrap in diff
au VimEnter * if &diff | execute 'windo set wrap' | endif

"" Search highlighting:
"highlight Search cterm=NONE ctermfg=white ctermbg=DarkBlue 


"
" _   _                         
"| |_| |__   ___ _ __ ___   ___ 
"| __| '_ \ / _ \ '_ ` _ \ / _ \
"| |_| | | |  __/ | | | | |  __/
" \__|_| |_|\___|_| |_| |_|\___|
"                               
" TrueColors
if (has("termguicolors"))
  set termguicolors
endif

if has("gui_running")
  " GUI is running or is about to start.              
  set lines=43 columns=75
   set guifont=PragmataPro
   set guioptions-=m  "Remove menubar
   set guioptions-=T  "Remove toolbar
   set guioptions-=r  "Remove scrollbar
  "colorscheme evening
  colorscheme gruvbox
  let g:airline_theme='gruvbox'
endif

"Material theme
""let g:material_theme_style = 'default' | 'palenight' | 'dark'
"colorscheme material
"let g:material_theme_style = 'dark'
"set background=dark

"" gruvbox available here: https://vimcolorschemes.com/morhetz/gruvbox
colorscheme gruvbox
let g:airline_theme='gruvbox'

"
" _     _           _ _                 
"| |__ (_)_ __   __| (_)_ __   __ _ ___ 
"| '_ \| | '_ \ / _` | | '_ \ / _` / __|
"| |_) | | | | | (_| | | | | | (_| \__ \
"|_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
"                             |___/     

" Save file with sudo
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :edit! | :q

" Misc
nnoremap zz :update<cr>
"nnoremap zo zz:!overleaf_pushmain<cr>
" Compile latex file main.tex
nnoremap zl :!pdflatex main.tex<cr>
" Temp file saving
vnoremap zs :w! tmp.do<cr>
vnoremap zj :w! tmp.jl<cr>
" Python save & execute section
"vnoremap zp :w! tmp.py<cr>:!python tmp.py<cr>
" Compile latex file (if it's called main.tex)
" Copy and paste
vnoremap zp "+P
"vnoremap zc "+y
"vnoremap zc :'<,'>w !xclip -selection c<cr><cr>
"" For X :
"vnoremap zc :w !xclip -selection cli<cr>
"" For wayland:
"vnoremap zc :'<,'>w !wl-copy <cr><cr>
vnoremap zc :'<,'>w !wl-copy <cr><cr>

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

"
" __  __ _          
"|  \/  (_)___  ___ 
"| |\/| | / __|/ __|
"| |  | | \__ \ (__ 
"|_|  |_|_|___/\___|
"                   

" Blinking highlights
" Damian Conway's Die Blinkënmatchen: highlight matches
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

" Can't remember what this is for, tbh
function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

