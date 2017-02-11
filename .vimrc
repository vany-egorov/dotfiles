set nocompatible

syntax on

" :hi CursorLine   cterm=NONE ctermbg=NONE ctermfg=white guibg=darkred guifg=white
" :hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=white guibg=darkred guifg=white
" :nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" :set cursorline

set t_Co=256
let base16colorspace=256

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'jpo/vim-railscasts-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'rust-lang/rust.vim'
Plug 'wincent/command-t', {
	\   'do': 'cd ruby/command-t && ruby extconf.rb && make'
	\ }
" Initialize plugin system
call plug#end()

colorscheme railscasts

set laststatus=2 " vim-airline
let g:airline#extensions#tabline#enabled = 1 " vim-airline
set backspace=2 " make backspace work like most other apps

map <C-n> :NERDTreeToggle<CR>
map <C-P> :CommandTBuffer<Enter>

