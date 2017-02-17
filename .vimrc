set nocompatible
set hidden

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
" Plug 'chriskempson/base16-vim'
Plug 'rust-lang/rust.vim'
" Plug 'wincent/command-t', {
"         \   'do': 'cd ruby/command-t && ruby extconf.rb && make'
"         \ }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'moll/vim-bbye'
Plug 'scrooloose/nerdcommenter'
Plug '907th/vim-auto-save'
Plug 'jceb/vim-orgmode'
" Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Initialize plugin system
call plug#end()

colorscheme railscasts

set laststatus=2 " vim-airline
set backspace=2 " make backspace work like most other apps
set showcmd
" set relativenumber
" set number
set lazyredraw
let NERDTreeShowHidden=1
let g:airline#extensions#tabline#enabled = 1 " vim-airline
let g:airline#extensions#tabline#fnamemod = ':t' " Name of buffer to only filename instead of path
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:auto_save = 1 " enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1 " do not change the 'updatetime' option
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}

autocmd FileType nerdtree set norelativenumber
autocmd FileType nerdtree set nocursorline
autocmd FileType taglist set norelativenumber
set cursorline
set hlsearch
hi CursorLine gui=underline cterm=underline
hi Search ctermbg=70

map <C-n> :NERDTreeToggle<CR>
" map <C-P> :CommandTBuffer<Enter>
nmap <silent> <Leader>c :Commands<CR>
nmap <silent> <Leader>b :Buffers<CR>
nmap <silent> <Leader>r :BTags<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <silent> <Leader>w :Bdelete<CR>
nmap <C-B><C-B> :set invnumber<CR>
nmap <C-M><C-M> :set relativenumber!<CR>
nmap <C-K><C-K> :set list!<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
