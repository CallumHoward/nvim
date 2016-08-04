"dein Scripts-----------------------------
set runtimepath^=/Users/callumhoward/.dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('/Users/callumhoward/.dein/'))

" Add or remove plugins here:
call dein#add('Shougo/dein.vim')                    " plugin manager
call dein#add('Shougo/deoplete.nvim')               " auto popup completion
call dein#add('Shougo/neosnippet.vim')              " snippet expansion
call dein#add('CallumHoward/neosnippet-snippets')   " snippet collection
call dein#add('neomake/neomake')                    " syntax checker
call dein#add('airblade/vim-gitgutter')             " line git status
call dein#add('kshenoy/vim-signature')              " marks in signs column
call dein#add('Konfekt/FastFold')                   " don't unfold in insert
call dein#add('tpope/vim-rsi')                      " enable readline key mappings
call dein#add('takac/vim-hardtime')                 " disable rapid hjkl repeat
call dein#add('CallumHoward/vim-neodark')           " colorscheme
call dein#add('rhysd/vim-clang-format', {'on_ft': ['c', 'cpp']})

call dein#end()
filetype plugin indent on
let g:dein#install_log_filename = '/Users/callumhoward/.dein/dein_install.log'
"End dein Scripts-------------------------

" base configuration
colorscheme neodark
syntax on

inoremap kj <Esc>
"set number          " enable line numbers
set list            " display hidden characters
set shortmess+=I    " disable splash screen message

set expandtab       " expand tabs to spaces
set shiftwidth=4    " spaces to shift when re-indenting
set tabstop=4       " number of spaces to insert when tab is pressed
set softtabstop=4   " backspace deletes indent
set smartindent     " indent based on filetype
set nowrap          " don't wrap text

set pumheight=5     " maximum number of iterms in completion popup

set ignorecase      " for search patterns
set smartcase       " don't ignore case if capital is used

set undofile        " undo persists after closing file
"set backup          " backup files

set splitright      " puts new vsplit windows to the right of the current
set splitbelow      " puts new split windows to the bottom of the current

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1  " dynamic cursor shape in supported terminals

set fcs=fold:-      " verticle split is just bg color
set foldcolumn=0    " visual representation of folds
set foldmethod=syntax
set foldnestmax=1
set nofoldenable

" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set title for tmux
autocmd BufEnter * call system('tmux rename-window ' . expand('%:t'))

" update diff on write NOTE: doesn't appear to work
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" movement mappings
nnoremap j gj
nnoremap k gk
nnoremap z] :<C-u>silent! normal! zc<CR>zjzozz
nnoremap z[ :<C-u>silent! normal! zc<CR>zkzo[zzz
inoremap {<CR> {<CR>}<Esc>O

" relative number configuration
autocmd FocusLost,InsertEnter,WinLeave ?* if &ma && &ft !~ 'markdown\|text' && &bt != 'nofile' | :setl nornu | endif
autocmd FocusGained,InsertLeave,WinEnter ?* if &ma && &ft !~ 'markdown\|text' && &bt != 'nofile' | :setl nu rnu | endif
autocmd FocusLost,InsertEnter,WinLeave,CmdwinLeave ?* if !&wrap || &bt == 'help' | :setl nocul | endif
autocmd FocusGained,InsertLeave,WinEnter,CmdwinEnter ?* if !&wrap || &bt == 'help'| :setl cul | endif

" netrw filebrowser config
let g:netrw_winsize = -28               " absolute width of netrw window
let g:netrw_banner = 0                  " do not display info on the top of window
let g:netrw_liststyle = 3               " tree-view
let g:netrw_sort_sequence = '[\/]$,*'   " sort so directories on the top, files below
let g:netrw_browse_split = 4            " use the previous window to open file

" automatically save and load views
au BufWinLeave ?* mkview
au BufWinEnter ?* silent! loadview

" enable omnicompletion
set tags+=~/.config/nvim/systags
autocmd Filetype * if &omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif

" use deoplete completion
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" neosnippet key-mappings
nmap <C-k>     i<Plug>(neosnippet_expand_or_jump)
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" gitgutter config
set updatetime=500
hi GitGutterAdd ctermfg=2
hi GitGutterChange ctermfg=3
hi GitGutterDelete ctermfg=1 cterm=bold
hi GitGutterChangeDelete ctermfg=1
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed =  '.'
let g:gitgutter_sign_removed_first_line =  '˙'
let g:gitgutter_sign_modified_removed = '│'
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

" signature config
let g:SignatureMap = {'Leader' : 'm'}   " disable extra mappings
let g:SignatureMarkTextHLDynamic = 1    " keep gitgutter highlight color
let g:SignatureForceMarkPlacement = 1   " use :delm x to delete mark x
let g:SignatureMarkTextHL = 'ErrorMsg'

" vim-clang-format config
let g:clang_format#command = '/usr/local/Cellar/llvm/3.8.1/bin/clang-format'
let g:clang_format#code_style = "llvm"
let g:clang_format#auto_formatexpr = 1
let g:clang_format#style_options = {
        \ "AccessModifierOffset" : -4,
        \ "AlignAfterOpenBracket" : "DontAlign",
        \ "AlignOperands" : "false",
        \ "AllowShortBlocksOnASingleLine" : "true",
        \ "AllowShortCaseLabelsOnASingleLine" : "true",
        \ "AllowShortFunctionsOnASingleLine" : "true",
        \ "AllowShortIfStatementsOnASingleLine" : "true",
        \ "AllowShortLoopsOnASingleLine" : "true",
        \ "ConstructorInitializerIndentWidth" : "8",
        \ "ContinuationIndentWidth" : "8",
        \ "IndentWidth" : "4",
        \ "SpacesBeforeTrailingComments" : "2",
        \ "Standard" : "C++11",
        \ "TabWidth" : "4"}

" neomake config
autocmd! BufWritePost * Neomake         " lint on save
hi NeomakeErrorSign ctermfg=1 ctermbg=none
hi NeomakeWarningSign ctermfg=9 ctermbg=none
hi NeomakeInfoSign ctermfg=5 ctermbg=none
hi NeomakeMessageSign ctermfg=5 ctermbg=none
let g:neomake_error_sign = {'text': '-!', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '-!', 'texthl': 'NeomakeWarningSign'}
let g:neomake_info_sign = {'text': '-i', 'texthl': 'NeomakeInfoSign'}
let g:neomake_message_sign = {'text': '->', 'texthl': 'NeomakeMessageSign'}
let g:neomake_cpp_enable_makers = ['clang', 'clangtidy']
let g:neomake_cpp_clang_args = ['-std=c++14', '-Wextra', '-Wall', '-Wno-unused-parameter', '-g']

" hardtime on
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
let g:hardtime_showmsg = 1
