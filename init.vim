"dein Scripts-----------------------------
set runtimepath^=/Users/callumhoward/.dein//repos/github.com/Shougo/dein.vim

call dein#begin(expand('/Users/callumhoward/.dein/'))

" Add or remove plugins here:
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('CallumHoward/neosnippet-snippets')
call dein#add('Shougo/deoplete.nvim')
"call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'})
"call dein#add('zchee/deoplete-clang', {'on_ft': ['c', 'cpp']})
call dein#add('neomake/neomake')
call dein#add('airblade/vim-gitgutter')
"call dein#add('tobiasgehring/ShowMarks')
call dein#add('CallumHoward/vim-neodark')

call dein#end()
filetype plugin indent on
"End dein Scripts-------------------------

colorscheme neodark
syntax on

inoremap kj <Esc>
set number         " enable line numbers
set list           " display hidden characters

set expandtab       " expand tabs to spaces
set shiftwidth=4    " spaces to shift when re-indenting
set tabstop=4       " number of spaces to insert when tab is pressed
set softtabstop=4   " backspace deletes indent
set smartindent     " indent based on filetype
set nowrap

set pumheight=5     " maximum number of iterms in completion popup

set ignorecase
set smartcase

set foldcolumn=0   " visual representation of folds
set foldmethod=syntax
set foldnestmax=1
set nofoldenable

nnoremap zj :<C-u>silent! normal! zc<CR>zjzo
nnoremap zk :<C-u>silent! normal! zc<CR>zkzo[z

set splitright     " Puts new vsplit windows to the right of the current
set splitbelow     " Puts new split windows to the bottom of the current

" use tabs for makefiles
autocmd FileType make set noexpandtab

" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" use deoplete completion
let g:deoplete#enable_at_startup=1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

let g:deoplete#file#enable_buffer_path=1
let g:deoplete#sources#jedi#enable_cache=1
let g:deoplete#sources#jedi#show_docstring=0
let g:deoplete#sources#clang#libclang_path="/usr/local/opt/llvm/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header="/usr/local/opt/llvm/lib/clang"
let g:neosnippet#snippets_directory="/Users/callumhoward/.dein/repos/github.com/CallumHoward/neosnippet-snippets/neosnippets"

" Plugin key-mappings
nmap <C-k>     i<Plug>(neosnippet_expand_or_jump)
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"autocmd InsertLeave * pclose " To close preview window of deoplete automagically

" enable omnicompletion
set tags+=~/.config/nvim/systags
autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
"au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

" lint on save
autocmd! BufWritePost * Neomake

" relative number configuration
autocmd FocusLost,InsertEnter,WinLeave * if &ma | :set nornu | endif
autocmd FocusGained,InsertLeave,WinEnter * if &ma | :set rnu | endif
autocmd FocusLost,InsertEnter,WinLeave * :set nocul
autocmd FocusGained,InsertLeave,WinEnter * :set cul


" Set Title
autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))

" verticle split is just bg color
set fillchars=fold:-

" showmarks configuration
"hi SignColumn ctermbg=none
"let g:showmarks_textlower=" "
"let g:showmarks_textupper=" "
"let g:showmarks_textother=" "
"let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]\""
"
"hi ShowMarksHLl ctermfg=14 ctermbg=none
"hi ShowMarksHLu ctermfg=14 ctermbg=none
"hi ShowMarksHLo ctermfg=11 ctermbg=none
"hi ShowMarksHLm ctermfg=14 ctermbg=none
"
"autocmd BufEnter * ShowMarksOn
set updatetime=500

" gitgutter config
hi GitGutterAdd ctermfg=2
hi GitGutterChange ctermfg=3
hi GitGutterDelete ctermfg=160 cterm=bold
hi GitGutterChangeDelete ctermfg=3
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed =  '.'
let g:gitgutter_sign_modified_removed = '│'

" netrw filebrowser config
let g:netrw_winsize = -28               " absolute width of netrw window
let g:netrw_banner = 0                  " do not display info on the top of window
let g:netrw_liststyle = 3               " tree-view
let g:netrw_sort_sequence = '[\/]$,*'   " sort is affecting only: directories on the top, files below
let g:netrw_browse_split = 4            " use the previous window to open file
