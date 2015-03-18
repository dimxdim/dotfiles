" NeoBundle init
if !1 | finish | endif

if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" Themes
NeoBundle 'nanotech/jellybeans.vim'     " jellybeans theme
NeoBundle 'morhetz/gruvbox'             " gruvbox theme
NeoBundle 'dimxdim/jellybat'             " jellybat theme
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'vim-scripts/wombat256.vim'

" Serious plugins
NeoBundle 'matchit.zip'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'bling/vim-airline'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'jiangmiao/auto-pairs'
" For theme related stuff, also check end of this file for mappings
"NeoBundle 'vim-scripts/SyntaxAttr.vim' "check syntax group under cursor <F11>
"NeoBundle 'gerw/vim-HiLinkTrace' "check all possible syntax groups under cursor <F9>
"NeoBundle 'guns/xterm-color-table.vim' "print color table with corresp color codes <F10>
"NeoBundle 'lilydjwg/colorizer' "print color table with corresp color codes <F8>

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"" System general settings
set shortmess+=I                                    " disable start message
set mouse=a                                         "enable mouse
set encoding=utf-8                                  "set encoding for text
set ttyfast                                         "assume fast terminal connection, fast redraws
set hidden                                          "allow buffer switching without saving
set fileformats+=mac                                "add mac to auto-detection of file format line endings
set nrformats-=octal                                "always assume decimal/hex numbers

"" Visual general settings
set showcmd             " show (partial) command in bottom-right
set number              " show line numbers
syntax on           " syntax enable syntax processing, *syntax on* overrides with defaults!
set showmatch           " highlight matching [{()}]
set scrolloff=200		" no. of lines shown above/below cursor, large no. will always have cursor in middle

"" Tabs and spaces
"set tabstop=4       " number of visual spaces per TAB
"set softtabstop=4   " number of spaces in tab when editing
"set shiftwidth=4    " for indentation command in normal mode
"set expandtab       " tabs are spaces
"set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start      "allow backspacing everything in insert mode
set list                 "highlight whitespace
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮,nbsp:■	" whitespaces to show (tab:│\ old, ▸\ new)
"set shiftround			" Round indent to multiple of 'shiftwidth'. +Applies to > and <
"set smarttab		" insert blanks according to shiftwidth (else tabstop or softtabstop)
set wrap            " wrap text on eol (default)
let &showbreak='↪ '	" Char to signify line break
set autoindent		" The simplest automatic indent

" Clipboard
if exists('$TMUX')
    set clipboard=
else
    if has('unnamedplus')
        set clipboard=unnamedplus                             "sync with "CLIPBOARD" OS clipboard, uses "+ register
    else
        set clipboard=unnamed                             "sync with "PRIMARY" OS clipboard, uses "* register
    endif
endif

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          "ignore case for searching

" Wildmenu
set wildmenu            " visual autocomplete for command menu
set wildmode=list:longest		" if more than one match show list
set wildignorecase		" ignore case in wildmenu search

"" Keyboard and cursor
set timeout ttimeout         " enable separate mapping and keycode timeouts
set timeoutlen=250                                  "mapping timeout ms (default 1000)
set ttimeoutlen=50                                  "keycode timeout ms (default -1, unset when having ssh with latency)

" Add tags from tag folder (libraries)
" remove searching tags in current file's directory
" tags should be read only from ~/tags/*.tags and from current working dir
" (not from current file's dir if its different from working dir)
set tags-=./tags
set tags-=./TAGS
set tags+=~/tags/cpp_std_gcc.tags
set tags+=~/tags/qt5.tags

"" Tags
"" if has('path_extra') " from sensible.vim
""  setglobal tags-=./tags tags^=./tags;
"" endif
"" set tags=tags;/			" from bling's vimrc
"set showfulltag 		" shows tag and search pattern as matches

" GUI
if has('gui_running')
	"set guicursor=n-v-c:blinkon0-block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175 "dont blink
	let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')
	"set guicursor=
	"set lines=999 columns=9999  " open maximized
	set guioptions-=t                                 "no tear off menu items
	set guioptions+=c                                 "no gui dialogs
	set guioptions-=T                                 "no toolbar icons
	set guioptions-=r                                   " no right scrollbar
	set guioptions-=l           " no left scrollbar
	set guioptions-=L           " no left scrollbar when vert. split
	set guioptions-=m           " no menu
	set guifont=MonaVu\ 10
else
	set t_Co=256			" terminal colors 256
endif

colorscheme jellybat

"" Special highlight of 81st char in long line (from TARBALL)
highlight MyColorColumn guifg=#d8d8d8 guibg=#ab4642 guisp=NONE gui=NONE ctermfg=7 ctermbg=1 cterm=NONE
call matchadd('MyColorColumn', '\%81v', 100)

" Key remaps
" Swap : and ; to make colon commands easier to type
" The vice versa remapping *may* break plugins - to be confirmed
nnoremap  ;  :
nnoremap  :  ;
vnoremap  ;  :
vnoremap  :  ;

" map leader key to , find char again \, find char again backwards |
" another option is "map <Space> <Leader>" but will not trigger double leader
" aka <Leader><Leader> mappings
" let mapleader = "\<Space>" if let mapleader = " " doesnt work
" also if remapped leader is continuously pressed, next leader presses will
" not be triggered until modes are changed (easymotion probably is culprit)
"nnoremap <Space> <Nop>
"vnoremap <Space> <Nop>
"let mapleader = " "
let mapleader = "\<Space>"

" the below 2 lines dont work somehow - spit message on startup TODO
"nnoremap \ ;   <--- problematic
"nnoremap | ,

" " avoid unrecoverable deletion (of all entered chars in line) in insert mode
"inoremap <c-u> <c-g>u<c-u>
"" avoid unrecoverable deletion (of word before cursor) in insert mode
"inoremap <c-w> <c-g>u<c-w>

" for new xcape mappings of alts == - and +
"noremap - {
"noremap + }

" for navigation of wrapped lines --> investigate side effects
nnoremap j gj
nnoremap k gk

" map ) and ( to :bnext and :bprev
nnoremap <silent> ) :bnext<CR>
nnoremap <silent> ( :bprev<CR>

" If you visually select something and hit paste
" that thing gets yanked into your buffer. This
" generally is annoying when you're copying one item
" and repeatedly pasting it. This changes the paste
" command in visual mode so that it doesn't overwrite
" whatever is in your paste buffer.
vnoremap p "_dP

" x in normal or visual will not overwrite the paste buffer
nnoremap x "_x
vnoremap x "_x

" X deletes to black hole till end of line
nnoremap X "_D

" Y yanks till end of line, instead of whole line
nnoremap Y y$

" stop highlighting search pressing <ESC>

" BEGIN_WORKAROUND
	" needs <esc>smth mapped in order to trigger timeout.
	" only then it will work. else numbers on startup in terminal.
		nnoremap <silent> <ESC><ESC> :nohlsearch<CR><ESC>
		nnoremap <silent> <ESC> :nohlsearch<CR><ESC>
" END_WORKAROUND

" GUI doesnt need workaround, so lets not add delay of <esc><esc>.
if has('gui_running')
	unmap <silent> <ESC><ESC>
	nnoremap <silent> <ESC> :nohlsearch<CR><ESC>
endif

"====[ Swap V and CTRL-v. Regular visual is now Shift-v. ]======
"====[ Block mode is more useful that Visual mode ]======
nnoremap    v   <C-V>
vnoremap    v   <C-V>
nnoremap <C-V>     V
vnoremap <C-V>     V
nnoremap    V   v
vnoremap    V   v

"====[ Use tab instead of % for jumping to matching parens - breaks <C-i> - bug ]
"nnoremap <tab> %
"vnoremap <tab> %

" move to beginning/end of line (also consider B and E as alternative)
noremap H ^
noremap L $

"====[ '*' in visual will do search on selection - the correct way ]======
vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Cool terminal shape when in xterm
if &term =~ '^xterm'
  " solid underscore
  let &t_SI .= "\<Esc>[6 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 2 solid block
  " 3 -> blinking underscore
  " 4 -> solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

" TODO:
" Find mappings for the following actions
" - delete buffer aka :bd
" - save buffer aka :w

" Plugin settings
"{{{
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    set laststatus=2    " Always show status bar
"}}}
"
" WORKAROUND1 FOR https://github.com/Valloric/YouCompleteMe/issues/526
" When using <BS> completion results change and become less
" <C-w> to begin typing again will give correct results, but maybe not worth
" retyping. This will most likely break deletion in any pair auto close plugins.
inoremap <expr><BS> pumvisible()? "\<C-y>\<BS>" : "\<BS>"

" WORKAROUND2 for the workaround above
" We can either have correct results after <BS> *OR* removed brackets after <BS>
let g:AutoPairsMapBS=0

let g:EasyMotion_off_screen_search=0

" mappings of <F>'s

" enter paste mode on pressing F4, to stop autoindenting etc, not needed when
" using "+ register -- to be confirm
set pastetoggle=<F4>
" for saving (writing out) as root - small delay on w in command line
cmap <F12> w !sudo tee % >/dev/null
" F's for plugins
"nnoremap <F11> :call SyntaxAttr()<CR>
"nnoremap <F10> :XtermColorTable<CR>
"nnoremap <F9> :HLT<CR>
"nnoremap <F8> :ColorToggle<CR>
