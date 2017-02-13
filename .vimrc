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
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'moll/vim-bbye'
Plug 'scrooloose/nerdcommenter'
Plug '907th/vim-auto-save'
" Initialize plugin system
call plug#end()

colorscheme railscasts

set laststatus=2 " vim-airline
let g:airline#extensions#tabline#enabled = 1 " vim-airline
set backspace=2 " make backspace work like most other apps
let NERDTreeShowHidden=1
set showcmd
" set relativenumber
set number
let g:airline#extensions#tabline#fnamemod = ':t' " Name of buffer to only filename instead of path
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:auto_save = 1 " enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1 " do not change the 'updatetime' option
autocmd FileType nerdtree set norelativenumber
autocmd FileType taglist set norelativenumber

map q <Nop>
map <C-n> :NERDTreeToggle<CR>
" map <C-P> :CommandTBuffer<Enter>
nnoremap <silent> <Leader>w :Bdelete<CR>
nmap <C-B><C-B> :set invnumber<CR>
nmap <C-K><C-K> :set relativenumber!<CR>
nmap <C-M><C-M> :set list!<CR>

