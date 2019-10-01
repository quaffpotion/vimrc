"### If there's a problem search *WARNING* first
"### Changes listed most recent first below:
"useful: tab help buffer, tabexplore, can keep folded view of file in a
"separate tab and mark the buffer there (ma) then go back ('a) in the full
"view tab
"useful: :e . (opens a file browser)
"Added ~/.vim/docs and surround.txt to it then ran :helptags ~/.vim/docs to
"	generate new tags, can now type e.g. :help ys
"visually select, S<character e.g. }> to surround selection
"normal mode <C-^> goes to last buffer
"command mode :Tex, :Sex to browse file system
"command mode <C-R><register name> to put contents of register
"dvj - deletes from cursor position until character below cursor b/c v forces
"      characterwise motion
"gc for commenting on visual mode, gcc for a line, >> to indent
"
"<C-r><register letter> paste contents of register into ex-mode command
"
"
"
"

"plugins
"begin plugin comments
" - quicktex uses function not available in older vim that comes w/ mac
"end plugin comments
"
call plug#begin('~/.vim/plugged')
Plug 'brennier/quicktex'
Plug 'tpope/commentary'
Plug 'tpope/vim-surround'
call plug#end()
":pluginstall 
":plugupdate 
"
"items sit in plugged and it automatically places things in the correct spot
"to edit commands for quicktex look in .vim/plugged/quicktex/ftplugin/tex

"ampersand tells vim its a config not just any old variable, -i for
"interactive so it loads commands
"also seems to not go back into vim right away
"let &shell='/usr/local/bin/zsh -i'


colorscheme zenburn
syntax on

"indent settings
filetype plugin indent on 
set tabstop=4
set shiftwidth=4
set expandtab

set autochdir  "This may break some plugins *WARNING*
set relativenumber
set hidden
set wildmenu
set ignorecase "ignore case, except when using capitals
set smartcase
set autoindent
set ruler
set hlsearch
set confirm
set laststatus=2
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
"set foldmethod=marker "use {{{n where n is a number to mark folds
set noswapfile
set nohlsearch
set incsearch
set undofile
set undodir=~/undodir


"in insert mode use ;; to exit
inoremap ;; <Esc>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l


noremap <C-u>  <C-u><C-L>       

" %:p is for full filename; otherwise pdflatex will compile in home directory
let mapleader = ","
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>sv :w<CR>:so $MYVIMRC<CR>
nnoremap <leader>c :w<CR>:!pdflatex %:p<CR> 
nnoremap <leader>dd <C-w>n:e ~/.vim/plugged/quicktex/ftplugin/tex/default_keywords.vim<CR>

"lists buffers and writes buffer goto command, b accepts both numbers and
"partial filenames w/ tab completion!
nnoremap gb :ls<CR>:b<space>

"Ctrl+a shortcut for going to last edited buffer
noremap <C-a> :b#<CR>

"really, want to get this to work so I can type ,dd in insert mode and then
"exectute the command grep STRING PATH_TO_DICTIONARY to get quick lookups of
"things I forgot
"nnoremap <leader>xxx :call execute("normal! i".input('Param: '))<CR>
"nnoremap <leader>ttt :call execute("! echo ".input('Param: '))
"nnoremap <leader>yyy :call execute("normal! ihello")


"visual mode, surround in delimiters>
vnoremap sp <Esc>`<i\left(<Esc>`>6la\right)<Esc>7h

"note: <leader><leader>( makes user have to press another key to see it
"execute. Vim still looking for more after the first (? two leader keys isn't
"unique enough? update: possible bug, brennier
"bug: breaks at beginning of lines

"operator pending, use with commands like y, d, c
"position cursor between \left( and \right) and type <operation>p e.g. dp to
"delete
onoremap p :<C-u>execute "normal! /\\\\right)\rhv?\\\\left(\r6l"<CR>  

"e.g. aaaa_bbbbbb_aaaaaa.... type vi_ or ci_ or ca_ while in the b's
" see also: https://github.com/paradigm/TextObjectify 
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" moving up and down with == to keep indents as per vim settings
" nnoremap <Down> :m .+1<CR>==
" nnoremap <Up> :m .-2<CR>==
" inoremap <Down> <Esc>:m .+1<CR>==gi
" inoremap <Up> <Esc>:m .-2<CR>==gi
" vnoremap <Down> :m '>+1<CR>gv=gv
" vnoremap <Up> :m '<-2<CR>gv=gv

"moving up and down without the ==, moves as is, with tabs->spaces seems to
"work best
nnoremap <Down> :m .+1<CR>
nnoremap <Up> :m .-2<CR>
inoremap <Down> <Esc>:m .+1<CR>gi
inoremap <Up> <Esc>:m .-2<CR>gi
vnoremap <Down> :m '>+1<CR>gv
vnoremap <Up> :m '<-2<CR>gv
