
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/molokai'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'scrooloose/syntastic'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'jiangmiao/auto-pairs'
call vundle#end()

filetype plugin indent on
""Ok. Done.

set backspace=indent,eol,start
set number
set nowrap
set hidden
inoremap jk <ESC>
let mapleader=","

" we also want to get rid of accidental trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" =================================================
" ----------
" Navigation
" ----------
" tell vim to allow you to copy between files, remember your cursor
" position and other little nice things like that
" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <leader>n :bn<CR>
map <leader>p :bp<CR>
map <leader>d :Bclose<CR>

" =================================================
" -------------
" Golang Config
" -------------
" tell vim to allow you to copy between files, remember your cursor
" position and other little nice things like that
set viminfo='100,\"2500,:200,%,n~/.viminfo
"
"" Open file at a position where it was last left.
au BufWinLeave *.go mkview
"au BufWinEnter *.go silent loadview

" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" =================================================
" ---------
" Syntastic
" ---------
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
" we want to tell the syntastic module when to run
" we want to see code highlighting and checks when  we open a file
" but we don't care so much that it reruns when we close the file
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

" =================================================
" -----------
" Color setup
" -----------
set t_Co=256
syntax enable
set background=dark
colorscheme distinguished

" =================================================
" -------
" Airline
" -------
" display fonts correctly for airline
"set encoding=utf-8
" Allows the bottom status line for airline to be shown
set laststatus=2
let g:airline_powerline_fonts=1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" =================================================
" --------
" NerdTree
" --------
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"" =================================================
"" ----
"" Tmux
"" ----
"" let g:tmux_navigator_save_on_switch = 1

" =================================================
" -----------
" CodeFolding
" -----------
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" =================================================
" ------
" TagBar
" ------
nmap <silent> <leader>tt :TagbarToggle<CR>
let g:tagbar_autoclose = 0
let g:tagbar_left = 0
let g:tagbar_expand = 0
autocmd VimEnter *.go nested :TagbarOpen
autocmd TabEnter *.go nested :TagbarOpen

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" =================================================
" ------
" Ctrl-P
" ------
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'

" =================================================
" ------
" gotags
" ------
"  Auto generate tags
au BufWritePost *.go silent! !gotags -silent -R % > tags
" navigate back to where we jumped from
nnoremap <C-[> <C-t>
