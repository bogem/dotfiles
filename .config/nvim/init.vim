language en_US         " Force english language
set autoindent         " Enable autoindent
set backspace=2        " Make backspace work like most other apps
set colorcolumn=80     " Set up a ruler at 80 symbols
set clipboard=unnamed  " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set cursorline         " Highlight current line
set encoding=utf-8     " Set default encoding to UTF-8
set expandtab          " Insert space characters whenever the tab key is pressed
set exrc               " Enable project-specific .vimrc
set ff=unix            " Unix end of file
set guicursor=         " Disable cursor-styling
set history=1000       " Store a ton of history (default is 20)
set hlsearch           " Highlight found searches
set ignorecase         " Search case insensitive...
set smartcase          " ... but not it begins with upper case
set incsearch          " Shows the match while typing
set lazyredraw         " Wait to redraw
let mapleader = ','    " Set leader shortcut to a comma ','
set mousehide          " Hide the mouse cursor while typing
set number             " Show line numbers
set nocompatible       " Enables us Vim specific features
set noswapfile         " No swp files
set relativenumber     " Show numbers relative to current line
set shiftwidth=2       " Number of spaces inserted for indentation
set softtabstop=2      " Number of columns that will be added when you hit Tab in insert mode
set showmode           " Show the current mode
set splitright         " Puts new vsplit windows to the right of the current
set splitbelow         " Puts new split windows to the bottom of the current
set tabstop=2          " Number of columns a tab counts for
set termguicolors      " True colors
set ttyfast            " Indicate fast terminal conn for faster redraw
set visualbell         " Set bell off
set t_vb=
set wildmenu           " Enhance command-line completion

" Fix common typos
cabbrev Q quit
cabbrev W write

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Execute previous command in the right pane of tmux
nmap <Leader>r :!tmux send-keys -t right UP C-j <CR><CR>
nmap <Leader>f :!tmux send-keys -t bottom-right UP C-j <CR><CR>

" Insert tab literal with Shift-Tab
inoremap <S-Tab> <C-V><Tab>

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the "
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <Leader>a :cclose<CR>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Delete all trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e
set showbreak=>\ \ \

" Colorscheme
syntax enable
set t_Co=256
set background=light
colorscheme macvim

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

"------- vim-plug settings --------
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go'
Plug 'isRuslan/vim-es6'
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
Plug 'zchee/deoplete-go', { 'do': 'make' }
call plug#end()
filetype plugin on
"------- End vim-plug settings ---

function! Find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! CD_git_root()
  let l:root = Find_git_root()
  execute 'cd' l:root
endfunction

"------- fzf settings -------
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

command! ProjectFiles execute 'Files' Find_git_root()

nnoremap <C-p> :ProjectFiles<CR>
nnoremap <Leader>b :Buffer<CR>
nnoremap <Leader>w :Windows<CR>
"------- End fzf settings ---

"------- echodoc settings -------
let g:echodoc#enable_at_startup = 1
set noshowmode
"------- End echodoc settings ---

"------- deoplete settings -------
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 30)
call deoplete#custom#source('_', 'max_menu_width', 160)

" Silence the  messages in the command line
" such as 'The only match', 'Pattern not found', 'Back at original", etc.
set shortmess+=c

" Don't show doc window
set completeopt-=preview
"------- End deoplete settings ---

"------- nvim-typescript settings -------
let g:nvim_typescript#max_completion_detail = 50

nnoremap <leader>d :TSDefPreview<CR>
nnoremap <leader>i :TSType<CR>
"------- End nvim-typescript settings ---

"------- vim-go settings -------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

au FileType go nmap <Leader>d <Plug>(go-def)
au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go setl sw=2 sts=2 noexpandtab

" Open :GoDecls with ctrl-g
nmap <C-g> :GoDecls<CR>
"------- End vim-go settings ---

"------- ack.vim settings -------
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack!
cnoreabbrev Ag Ack!
"------- End ack.vim settings ---

"------- Javascript settings -------
let g:javascript_plugin_flow = 1

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md Prettier
"------- End Javascript settings -------

"------- neosnippet settings -------
imap <C-f> <Plug>(neosnippet_expand_or_jump)
"------- End neosnippet settings ---

"------- YouCompleteMe settings -------
" Use ycm only for diagnostics and only for Typescript.
let g:ycm_auto_trigger = 0
let g:ycm_filetype_whitelist = { 'typescript': 1 }
let g:ycm_enable_diagnostic_highlighting = 0

nnoremap <leader>g :YcmShowDetailedDiagnostic<CR>
"------- End YouCompleteMe settings ---

set secure " Disable unsafe commands in project-specific .vimrc files.
