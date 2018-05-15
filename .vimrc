""" Plugins
  " fzf config
  nmap <C-p> :Files<cr>
  imap <c-x><c-l> <plug>(fzf-complete-line)

  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-i': 'split',
    \ 'ctrl-s': 'vsplit' }
  let g:fzf_layout = { 'down': '~60%' }

  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,rs,ls,hpp,h,hs,rb,conf,fa,lst}"
    \ -g "!{.config,.git,node_modules,bower_components,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist}/*" '

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
" Plug 'jpo/vim-railscasts-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'rust-lang/rust.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'moll/vim-bbye'
Plug 'scrooloose/nerdcommenter'
Plug '907th/vim-auto-save'
Plug 'jceb/vim-orgmode'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/twilight256.vim'
Plug 'flazz/vim-colorschemes'
" Plug 'vim-syntastic/syntastic'
Plug 'gkz/vim-ls'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf for user
Plug 'junegunn/fzf.vim'                                           " Fzf vim plugin
" Initialize plugin system
call plug#end()

""" ******
set nocompatible
set hidden
syntax on
set t_Co=256
set encoding=UTF-8

colorscheme twilight256
set fillchars+=vert:\│
hi clear VertSplit

set laststatus=2 " vim-airline
set backspace=2 " make backspace work like most other apps
set showcmd
" set relativenumber
" set number
set lazyredraw
let NERDTreeShowHidden=1
let g:airline#extensions#tabline#enabled = 1 " vim-airline
let g:airline#extensions#tabline#fnamemod = ':t' " Name of buffer to only filename instead of path
let g:airline_theme='minimalist'
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
hi CursorLine gui=NONE cterm=NONE
hi Search ctermbg=70
hi MatchParen cterm=none ctermbg=none ctermfg=yellow

" <syntastic>
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1

" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_rust_checkers = ['rustc']
" </syntastic>

" <go>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"
" </go>

""" Key modifiers
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
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

