syntax on
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-orgmode'
Plugin 'speeddating.vim'
Plugin 'The-NERD-tree'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'Localtog/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'amiorin/vim-project'
Plugin 'kien/ctrlp.vim'

call vundle#end()
filetype plugin indent on

let g:project_enable_welcome = 1
let g:project_use_nerdtree = 1

set rtp+=~/.vim/bundle/vim-project

call project#rc("/vagrant")

Project '/vagrant/drm'           , 'bbl-drm'
Project '/vagrant/monitoring-hls', 'bbl-monitoring-hls'


colorscheme railscasts

" set paste
set wrap
set backspace=indent,eol,start
set t_Co=256

if has('statusline')
	set laststatus=2

	set statusline=%<%f\
	set statusline+=%w%h%m%r
	set statusline+=%{fugitive#statusline()}
	set statusline+=\ [%{&ff}/%Y]
	set statusline+=\ [%{getcwd()}]
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	let g:syntastic_enable_signs=1
	set statusline+=%=%-14.(%l,%c%V%)\ %p%%
endif

let NERDTreeShowHidden=1

let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
