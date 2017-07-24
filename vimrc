" location of vimrc on windows c:\users\username\_vimrc
set nocompatible               " Be iMproved

set synmaxcol=128
" syntax sync minlines=256

" TODO make a check on startup to make sure that on windows the vimfiles dir is
" either empty or does not exist? (display an error and exit)
if !has('nvim') && (has('win32') || has('win64'))
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	let g:plughomeddd='~/.vim/plugged'
else
	let g:plughomeddd='~/.vim/plugged'
endif

" always start in home dir on windows
cd ~

" ================== Plugin manager ===========================================
call plug#begin(g:plughomeddd)

" --------------- Themes + visual
"Plug 'dimxdim/jellybat'

" solarized, supposedly more consistent than orig
" prev romainl/flattened commit
Plug 'romainl/flattened', {'commit': '048ad9e570a6b0cd671618ccb0138c171e0b9c52'}

" original solarized
" prev altercation/vim-colors-solarized commit
Plug 'altercation/vim-colors-solarized', {'commit': '528a59f26d12278698bb946f8fb82a63711eec21'}

" another solarized, between the above 2
" prev lifepillar/vim-solarized8 commit
Plug 'lifepillar/vim-solarized8', {'commit': 'b64bca5f6ce418589986a03e37df53b3d0625575'}

" Plug 'flazz/vim-colorschemes'
" Plug 'NLKNguyen/papercolor-theme'

" --------------- Plugins
" prev vim-airline/vim-airline commit a914cfb75438c36eefd2d7ee73da5196b0b0c2da
" Plug 'vim-airline/vim-airline', {'commit': '72ca1c344fc48f8a5dec7e8c4b75da0436176338'}

" prev vim-airline/vim-airline-themes commit
Plug 'vim-airline/vim-airline-themes', {'commit': '7865fd8ba435edd01ff7b59de06a9be73e01950d'}

Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
" " Alternative to bufferline
" " Plug 'taohex/lightline-buffer'

" prev easymotion/vim-easymotion commit d55e7bf515eab93e0b49f6f762bf5b0bf808264d
Plug 'easymotion/vim-easymotion', {'commit': 'e4d71c7ba45baf860fdaaf8c06cd9faebdccbd50'}

" prev jiangmiao/auto-pairs commit
" Alternative: delimitmate, suggested by ycm, also neopairs by shougo
Plug 'jiangmiao/auto-pairs', {'commit': '6afc850e2429e6832a1b093e32a31e0b5eff477d'}

" prev tommcdo/vim-exchange commit
Plug 'tommcdo/vim-exchange', {'commit': '05d82b87711c6c8b9b7389bfb91c24bc4f62aa87'}

" prev tpope/vim-surround commit
Plug 'tpope/vim-surround', {'commit': 'e49d6c2459e0f5569ff2d533b4df995dd7f98313'}

" prev tpope/vim-commentary commit
Plug 'tpope/vim-commentary', {'commit': 'be79030b3e8c0ee3c5f45b4333919e4830531e80'}

" make the above 2 repeatable
Plug 'tpope/vim-repeat', {'commit': '070ee903245999b2b79f7386631ffd29ce9b8e9f'}

" To check whether its working :echo vimproc#system('dir')
Plug 'Shougo/vimproc.vim', {'commit': '57cad7d28552a9098bf46c83111d9751b3834ef5'}

" Fullscreen gvim on windows (uses dll)
Plug 'derekmcloughlin/gvimfullscreen_win32', {'commit': '6abfbd13319f5b48e9630452cc7a7556bdef79bb'}

" Needs lua53.dll from http://lua-users.org/wiki/LuaBinaries (64bit like my vim) in the same dir as gvim.exe
" alternative source for lua binaries, mentioned on github vim distribution:
" http://luabinaries.sourceforge.net/download.html
" (also according to shougo/denite python can also be added this way from
" official site -> choose python embeddable and copy all zip contents to vim's
" install dir)
Plug 'Shougo/neocomplete', {'commit': 'd8caad4fc14fc1be5272bf6ebc12048212d67d2c'}

" TODO check out Ultisnips later, supposedly works well with ycm
" TODO check out nerdtree,
" TODO vim-javascript and flow for javascript static checking, also ternjs.
" TODO w0rp/ale, async linting, like syntastic?
" TODO check out ctrlp and also FelikZ/ctrlp-py-matcher for faster ctrlp
" also it is supposedly better on windows with ag. Ripgrep must be even
" faster.
" TODO check out IndentLine plugin to show "|" indent in projects using spaces.
" TODO check out EMMET plugin for efficient html production.
call plug#end()

" Eclim -> was installed by the installer with checked android support.
" REMINDER: set encoding to utf-8 in eclipse too.
" TODO check out CompleteTags for xml, html, md
" TODO check out michaeljsmith/vim-indent-object for selecting based on indentation
" TODO FYI alternative for airline mgee/lightline-bufferline.
" TODO check out fast fold plugin, folding may slow down autocompletion.
" TODO check out dispatch as async runner
" TODO check out tagbar for code's outline based off tags (classes, methods etc)
" TODO tag generation and updating: Gutentags

" Never upgrade vim-plug itself automatically:
delc PlugUpgrade
" =============================================================================

" ================== My settings =============================================
set backupcopy=yes " make windows change the linked file when editing symlinks
" no more netrw
let g:loaded_netrwPlugin = 1
" ------------------ GUI fonts
" as of Jul 2017 nvim always returns 0 for has("gui_running")
if has("gui_running")
	if has("gui_gtk2") " TODO add gtk3 too
		set guifont=Source\ Code\ Pro\ Medium\ 10
		" no extra spacing - not checked on gtk vim linux
		set linespace=0
		set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
	elseif has("gui_win32")
		set guifont=Source_Code_Pro_Medium:h10:cANSI:qDRAFT
		" no extra spacing, linespace was 1 by default, increase if
		" underlines cover other lines
		set linespace=0
		" set renderoptions=type:directx " see below, do not set for now
	elseif has("x11")
	" Also for GTK 1
	endif
endif

"" System general settings
set shortmess+=I                                    " disable start message
set mouse=a                                         "enable mouse
set encoding=utf-8                                  "set encoding for text
set ttyfast                                         "assume fast terminal connection, fast redraws
set hidden                                          "allow buffer switching without saving
set fileformats+=mac                                "add mac to auto-detection of file format line endings
set nrformats-=octal                                "always assume decimal/hex numbers

if exists('&shortname')                      "neovim does not have this
	set noshortname                      "no dos-style short names for files
endif

"" Visual general settings
set showcmd             " show (partial) command in bottom-right
set number              " show line numbers
syntax on           " syntax enable syntax processing, *syntax on* overrides with defaults!
set showmatch           " highlight matching [{()}]
set scrolloff=200       " no. of lines shown above/below cursor, large no. will always have cursor in middle
set noerrorbells visualbell t_vb= " no error bells at all
autocmd GUIEnter * set visualbell t_vb= " needed as gvim will reset t_vb

"" Tabs and spaces
"set tabstop=4       " number of visual spaces per TAB
"set softtabstop=4   " number of spaces in tab when editing
"set shiftwidth=4    " for indentation command in normal mode
"set expandtab       " tabs are spaces
"set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start      "allow backspacing everything in insert mode
set list                 "highlight whitespace
"set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮,nbsp:■   " does not display on windows without directx render
set listchars=tab:│\ ,trail:•,extends:»,precedes:«,nbsp:■
"set shiftround          " Round indent to multiple of 'shiftwidth'. +Applies to > and <
"set smarttab            " insert blanks according to shiftwidth (else tabstop or softtabstop)
set wrap            " wrap text on eol (default)
" let &showbreak='↪ '    " does not display on windows without directx render
let &showbreak='▶ '      " Char to signify line break
set autoindent           " The simplest automatic indent

" ------------------------------------------------------------------------------
" Force redraw on focus gain, fixes some visual bugs under gvim + windows
" May cause commands that spawn windows command prompt (like :PingEclim
" to be shown without the returned text, but with "press any key"), to see
" them use :messages (":mes"). To manual redraw: <c-l>
" TODO on win10 there is no cmd popup! Investigate! Try on win10 (with
" different builds: github, tux, kaoriya):
" :echo system('dir')

" if has('gui_running')
" 	augroup RedrawOnFocusDDD
" 		autocmd!
" 		autocmd FocusGained * :redraw!
" 	augroup END
" endif
" ------------------------------------------------------------------------------

" Clipboard
if has('unnamedplus')
	set clipboard=unnamedplus                             "sync with "CLIPBOARD" OS clipboard, uses "+ register
else
	set clipboard=unnamed                             "sync with "PRIMARY" OS clipboard, uses "* register
endif

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          "ignore case for searching

" Wildmenu
set wildmenu            " visual autocomplete for command menu
set wildmode=list:longest,full       " complete longest common, then cycle with tab, back cycle shift-tab
set wildignorecase                   " ignore case in wildmenu search

"" Keyboard and cursor
set timeout ttimeout         " enable separate mapping and keycode timeouts
set timeoutlen=400           " mapping timeout ms (default 1000)
set ttimeoutlen=50           " keycode timeout ms (default -1, unset when having ssh with latency)

" Add tags from tag folder (libraries)
" remove searching tags in current file's directory
" tags should be read only from ~/tags/*.tags and from current working dir
" (not from current file's dir if its different from working dir)
set tags-=./tags
set tags-=./TAGS

"" Tags
"" if has('path_extra') " from sensible.vim
""  setglobal tags-=./tags tags^=./tags;
"" endif
" set showfulltag         " shows tag and search pattern as matches

" always split below, when opening help/quickfix/etc
set splitbelow

" GUI
if has('gui_running')
	set guicursor=a:blinkon0 " dont blink, the rest are defaults ddd new
	set guioptions-=t                                 "no tear off menu items
	set guioptions+=c                                 "no gui dialogs
	set guioptions-=T                                 "no toolbar icons
	set guioptions-=r                                   " no right scrollbar
	set guioptions-=l           " no left scrollbar
	set guioptions-=L           " no left scrollbar when vert. split
	set guioptions-=m           " no menu
	set guioptions-=e           " no ugly GUI-style tabline
endif

" Setting formatoptions to define behavior when pressing enter on commented line to
" continue comments etc
" "set formatoptions" can be overriden by plugins
" https://superuser.com/questions/401090/how-to-prevent-certain-vim-formatoptions-from-being-enabled-by-ftplugins
" -=c will remove comment auto-line-break (:h formatoptions)
augroup myFormatOptsDDD
	autocmd!
	autocmd FileType * setlocal formatoptions-=t formatoptions-=o
augroup END

" open file with cursor on last edit (from :h last-position-jump)
augroup openFileWithCursorAtLastEditDDD
	autocmd!
	au BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
		\ |   exe "normal! g`\""
		\ | endif
augroup END

" <cr> follows links in help files
augroup enterFollowHelpLinkDDD
	autocmd!
	autocmd FileType help nnoremap <buffer> <cr> <c-]>
augroup END

" always show gutter(sign column)
augroup AlwaysShowGutterDDD
	autocmd!
	autocmd BufEnter * sign define dummy
	autocmd BufEnter * execute 'sign place 999999 line=1 name=dummy buffer=' . bufnr('')
augroup END
" ----------------------- KEY REMAPS
" Swap : and ; to make colon commands easier to type
" The vice versa remapping *may* break plugins - to be confirmed
nnoremap  ;  :
"nnoremap  :  ;
xnoremap  ;  :
"xnoremap  :  ;
" make comma the new ;
nnoremap , ;
xnoremap , ;

" Space is the new leader
nnoremap <Space> <Nop>
xnoremap <Space> <Nop>
let mapleader = "\<Space>"

" Disable <c-c> in insert, normally it exits to normal without triggering the
" InsertLeave autocommands - never a good idea.
inoremap <c-c> <nop>

" for navigation of wrapped lines --> investigate side effects
nnoremap j gj
nnoremap k gk

" map } and { to :bnext and :bprev
nnoremap <silent> } :bnext<CR>
nnoremap <silent> { :bprev<CR>

" jump paragraph with ( , )
nnoremap ( {
nnoremap ) }

" Paste over smth in visual does not overwrite the main '+' register.
xnoremap <silent> p p:let @+=@0<CR>
" TODO: detect when "dd"-ing empty/whitespace lines and stop overwriting "+"
" register, or bring back the other register.

" x will always delete to black hole
nnoremap x "_x
xnoremap x "_x

" X deletes to black hole till end of line
nnoremap X "_D

" Y yanks till end of line, instead of whole line
nnoremap Y y$

" Stop highlighting matching search pattern and any vim-exchange selections pressing <ESC>
" BEGIN_ESCAPE_WORKAROUND
	" In terminal <esc>smth must be mapped in order to trigger timeout.
	" Only then it will work. Else numbers shown on startup in terminal.
	" also, rapid pressing <esc><F*> will result in weird behavior, such
	" as entering insert mode and writing S for <esc><F4>.
	" Triple esc mapping prevents it.
	" At the end adding :execute "normal \<Plug>(ExchangeClear)"<CR>
	" to cancel any vim-exchange markings-highlights.
	" If there will be no further remaps of vim-exchange's cxc then ending
	" :call feedkeys("cxc")<CR>
	" should work too.
	" Also :call feedkeys("\<Plug>(ExchangeClear)")<CR> should work too.
	" Lastly, <Plug>(ExchangeClear) wont work without parens () around
	" ExchangeClear, they might be part of the name (?)
	" How to call <Plugs>: https://stackoverflow.com/questions/8862290/vims-plug-based-mappings-dont-work-with-normal-command
	" Also works:
		" nnoremap <silent> <ESC> :nohlsearch<CR><ESC>:call feedkeys("\<Plug>(ExchangeClear)")<CR>
	" My original mappings (before adding ExchangeClear):
		" nnoremap <silent> <ESC> :nohlsearch<CR><ESC>
		" nnoremap <silent> <ESC><ESC> :nohlsearch<CR><ESC>
		" nnoremap <silent> <ESC><ESC><ESC> :nohlsearch<CR><ESC>

" BEGIN_ESCAPE_WORKAROUND
" <ESC> clears search highlights and exhange marking highlights.
" GUI doesnt need <ESC><ESC> workaround, so lets not add the its delay.
if has('gui_running')
	nnoremap <silent> <ESC> :nohlsearch<CR><ESC>:execute "normal \<Plug>(ExchangeClear)"<CR>
	" the <ESC> mapping unmaps cxc for some reason, so redo the mapping
	nnoremap <silent> cxc :execute "normal \<Plug>(ExchangeClear)"<CR>
else
	nnoremap <silent> <ESC> :nohlsearch<CR><ESC>:execute "normal \<Plug>(ExchangeClear)"<CR>
	nnoremap <silent> <ESC><ESC> :nohlsearch<CR><ESC>:execute "normal \<Plug>(ExchangeClear)"<CR>
	nnoremap <silent> <ESC><ESC><ESC> :nohlsearch<CR><ESC>:execute "normal \<Plug>(ExchangeClear)"<CR>
	" the <ESC> mapping unmaps cxc for some reason, so redo the mapping
	nnoremap <silent> cxc :execute "normal \<Plug>(ExchangeClear)"<CR>
endif
" END_ESCAPE_WORKAROUND

"====[ Swap V and CTRL-v. Regular visual is now Shift-v. ]======
"====[ Block mode is more useful that Visual mode ]======
nnoremap    v   <C-V>
xnoremap    v   <C-V>
nnoremap <C-V>     V
xnoremap <C-V>     V
nnoremap    V   v
xnoremap    V   v

" move to beginning/end of line (also consider B and E as alternative)
" <C-H> by default in terminal is produced by backspace, using <C-J>
noremap <C-J> ^
noremap <C-K> $
" <C-K> appends to end of line, useful to escape auto-closing parens
inoremap <silent><C-J> <ESC><ESC>I
inoremap <silent><C-K> <ESC><ESC>A
" command mode move to beginning/end
cnoremap <C-A> <Home>
cnoremap <C-L> <End>

" ----------------------------------------------------------------
" Paste from main buffer into command mode, filterling out tabs and newlines
" does not modify my main "+" register, as it uses z register.
" This is useful for copy-pasting lines into command mode lines from vimrc.
" This will not work on multi-line selections to be pasted into command, use
" MyExecuteLineRangeDDD for this.
" double c-r at end to insert literally (whe yanked text contains "^h" it will
" not result in <BS> performed)
" <C-R>= prompts for an expression, BS will delete the 0 from the expression.
cnoremap <C-R> <C-R>=<SID>FilterNLTabYankToRegZ()<CR><BS><C-R><C-R>z
" filters tabs and new lines from clipboard: @+ into reg @z
" Tabs are replace by spaces just in case.
function! s:FilterNLTabYankToRegZ()
	let @z=substitute(@+, '\n', '', 'g')
	let @z=substitute(@z, '\t', ' ', 'g')
endfunction

" source selected lines into vim command (useful when testing scripts) using
":[range]MyExecuteLineRangeDDD    Execute text lines as ex commands.
" Also handles :h line-continuation.
" https://stackoverflow.com/questions/20262519/vim-how-to-source-a-part-of-the-buffer
command! -bar -range MyExecuteLineRangeDDD silent <line1>,<line2>yank z | let @z = substitute(@z, '\n\s*\\', '', 'g') | @z
xnoremap <Leader>r :MyExecuteLineRangeDDD<CR>

" use <C-T> to paste from specific register (the original <C-R> is now <C-T>)
cnoremap <C-T> <C-R>

" ----------------------------------------------------------------
" c-d exits(if last window, else closes window), aka always close window.
" Now it will not quit when having open an single buffer and a help window!
" TODO: shorten this to an expression mapping
" nnoremap <expr> <C-D> winnr() ==# winnr('$') ? execute 'quit'  : execute 'wincmd c')
nnoremap <C-D> :call MyCloseFuncDDD()<CR>
function! MyCloseFuncDDD()
	if winnr() ==# winnr('$')
		quit
	else
		wincmd c
	endif
endfunction

" c-s writes(if buffer was modified), c-c deletes buffer
nnoremap <silent><C-S> <ESC><ESC>:update<CR><ESC>
inoremap <silent><C-S> <ESC><ESC>:update<CR><ESC>

" <c-c> deletes current buffer.
" <c-c> interrupts terminal vim when busy (useful to break from endless loop)
" even if remapped. In GUI when remapped -> use CTRL-Break.
nnoremap <silent><C-C> :bdelete<CR>
" ----------------------------------------------------------------

" <leader>s performs substitution
nnoremap <Leader>s :%s/

" Reselect pasted text linewise, ( `[ is jump to beginning of changed/yanked )
nnoremap <Leader>v `[V`]

" Uppercase current word in norm/insert
nnoremap <C-\> gUiw
inoremap <C-\> <ESC>gUiwea

" Jump a word forward in insert mode
inoremap <C-e> <ESC>ea
" Jump a word back in insert mode
inoremap <C-b> <ESC>bi

"====[ '*' in visual to search on selection - the correct way ]=============
" <c-u> is needed to remove '<'> of visual
" edit: since * is just too far, <c-f> will become new * for visual and norm.
" xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
nnoremap * <nop>
xnoremap * <nop>
" <c-f> is the new * (F is for Find)
nnoremap <C-f> *
xnoremap <C-f> :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
" backward search on #
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
" The function itself
function! s:VSetSearch()
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

" In visual search for current selection to make it substitution target
" xmap <Leader>s *:<C-u>%s//
xnoremap <Leader>s :<C-u>call <SID>VSetSearch()<CR>:<C-u>set hlsearch<CR>:<C-u>%s//
" ============================================================================

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

	" 24bit color for mintty -> to be checked on xterm, hopefully perform.
	" is not affected and we can stop sourcing custom color palette into xterm.
	if exists('$OS') && $OS ==# 'Windows_NT'
		set termguicolors
	endif
endif

" ---------------------- COLORS
set background=dark " for original solarized theme
colorscheme flattened_dark
let g:solarized_underline=1

" after 80 columns the following columns background will be lighter (range max 256)
let &colorcolumn=join(range(81,336),",")

" ------------------------------------------------------------------------------
" make completion dropdown same style as comments but underlined + not italic
" TODO make this copy values: bg->from Norm, fg->from Comment instead of hardcoded values
" To actually do the above may require parsing etc. For now lets set up
" hardcoded values depending on theme to being switched to (solarized light)
" http://vim.wikia.com/wiki/Override_Colors_in_a_Color_Scheme
" https://vi.stackexchange.com/questions/9675/use-variables-in-colorscheme
" https://vi.stackexchange.com/questions/9644/how-to-use-a-variable-in-the-expression-of-a-normal-command
" https://superuser.com/questions/466662/vim-how-to-auto-sync-custom-syntax-highlight-rules-when-colorscheme-changes
" https://stackoverflow.com/questions/12449248/vim-autocmd-for-removing-colorscheme-background-fail-to-run
" https://github.com/mhinz/vim-janah/issues/2
" when changing multiple stuff use pipes like this:
" autocmd ColorScheme * highlight Normal ctermbg=NONE guifg=lightgrey guibg=black | highlight MatchParen cterm=bold ctermfg=red ctermbg=NONE gui=bold guifg=red guibg=NONE

" my default pmenu colors for solarized_dark
function! s:ColorPopupMenuSolDarkDDD()
	highlight Pmenu term=bold cterm=underline,bold ctermfg=10 ctermbg=8
		\ gui=underline,bold guifg=#586e75 guibg=#002b36
endfunction

function! s:ColorPopupMenuSolLightDDD()
	highlight Pmenu term=bold cterm=underline,bold ctermfg=14 ctermbg=15
		\ gui=underline,bold guifg=#93a1a1 guibg=#fdf6e3
endfunction

function! s:EasymotionNoBoldDarkDDD()
	highlight EasyMotionTarget ctermfg=12 guifg=#ff0000 gui=NONE cterm=NONE
	highlight EasyMotionTarget2First ctermfg=14 guifg=#ffb400 gui=NONE cterm=NONE
	highlight EasyMotionTarget2Second ctermfg=14 guifg=#b98300 gui=NONE cterm=NONE
endfunction

function! s:EasymotionNoBoldLightDDD()
	" EasyMotionTarget2First and second are reversed for better contrast
	highlight EasyMotionTarget ctermfg=12 guifg=#ff0000 gui=NONE cterm=NONE
	highlight EasyMotionTarget2Second ctermfg=14 guifg=#ffb400 gui=NONE cterm=NONE
	highlight EasyMotionTarget2First ctermfg=14 guifg=#b98300 gui=NONE cterm=NONE
endfunction

" when colorscheme is changed to solarized family dark/light
augroup ColorschemeChangeDDD
	autocmd!
	autocmd ColorScheme flattened_dark,solarized8_dark,solarized8_dark_flat
			\ call <SID>ColorPopupMenuSolDarkDDD()
			\ | call <SID>EasymotionNoBoldDarkDDD()
	autocmd ColorScheme flattened_light,solarized8_light,solarized8_light_flat
			\ call <SID>ColorPopupMenuSolLightDDD()
			\ | call <SID>EasymotionNoBoldLightDDD()
augroup END

" Call once to set the defaults.
doautocmd <nomodeline> ColorschemeChangeDDD ColorScheme flattened_dark

" ------------ For any statusline plugin ----------------
set laststatus=2    " Always show status bar

" always show tabline (Note: there used to be a bug in powerline that setting
" tabline to 2 would cause vim to update the tabline for every keystroke)
set showtabline=2

" ================== Plugin settings ==========================================
" ------------------ Lightline with mgee/lightline-bufferline
let g:lightline = {
			\ 'colorscheme': 'solarized',
			\ }
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#unnamed = "[No name]"

" -------------------- Vim-easymotion
" TODO maybe redo mappings? (see above mapping leader to <nop>)
" The below will undo all easymotion mappings (dunno why)
" let g:EasyMotion_do_mapping = 0

" For better performance (also doesnt make sense to search offscreen)
let g:EasyMotion_off_screen_search=0
" improve readability
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'

" new separate bindings for each shortcut
nnoremap <Leader>w :call feedkeys("\<Plug>(easymotion-prefix)w")<CR>
nnoremap <Leader>e :call feedkeys("\<Plug>(easymotion-prefix)e")<CR>
nnoremap <Leader>b :call feedkeys("\<Plug>(easymotion-prefix)b")<CR>
nnoremap <Leader>j :call feedkeys("\<Plug>(easymotion-prefix)j")<CR>
nnoremap <Leader>k :call feedkeys("\<Plug>(easymotion-prefix)k")<CR>
" feedkeys will not work with xnore, will cancel selection.
xmap <Leader>w <Plug>(easymotion-prefix)w
xmap <Leader>e <Plug>(easymotion-prefix)e
xmap <Leader>b <Plug>(easymotion-prefix)b
xmap <Leader>j <Plug>(easymotion-prefix)j
xmap <Leader>k <Plug>(easymotion-prefix)k

" -------------------- Auto-pairs
" Workaround to be used with completion plugins.
" We can either have correct results after <BS> *OR* removed brackets after <BS>
let g:AutoPairsMapBS=0

" Do not map space: now entering "( T" will not result in "( T )" but in "( T)".
" Still a small price to pay for less bugs with completion plugins.
let g:AutoPairsMapSpace=0

" -------------------- Vim-exchange
" xnore does not work, so using xmap
xmap <C-X> <Plug>(Exchange)

" -------------------- Vim-surround
" s surrounds {move}, S surrounds line
let g:surround_no_mappings = 1
nmap s   <Plug>Ysurround
nmap S   <Plug>Yssurround
" ds mapping is already in place, but rebind as a reminder
nmap ds  <Plug>Dsurround
" cs mapping is already in place, but rebind as a reminder
nmap cs  <Plug>Csurround
xmap s   <Plug>VSurround

" -------------------- Eclim
" make eclim and ycm/neocomplete play nice, omnifunc mapping in insert mode is <c-x><c-o>
let g:EclimCompletionMethod = 'omnifunc'

" do not echo error when completion fails - useful if neocomplete calls
" omnifunc eclim at inapropriate position.
" let g:EclimLogLevel = 'off'

" Disable eclim on mintty, causes errors on saving git commit message file.
" We have to make it into autocmd because eclim may not be loaded yet.
if exists('$OS') && $OS ==# 'Windows_NT' && &term =~ '^xterm'
	augroup disableEclimOnMinttyDDD
		autocmd!
		autocmd VimEnter * if exists(':EclimDisable') | execute 'EclimDisable' | endif
	augroup END
endif

" ------------------ Neocomplete
" TODO: on terminals <c-space> may not be valid. Use :<c-v><c-space> to see
" what it resolves to. Possibly <c-@>
" inoremap <expr><c-space> pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()
" inoremap <expr><s-space> pumvisible() ? "\<C-p>" : neocomplete#start_manual_complete()

" INFO: there is no way to get fuzzy autocomplete from eclim omni after having
" some letters after ".". Example: this will complete "s.<c-space>", while
" this will not: "s.toStr<c-space>". The best way when having custom manual
" timer (auto timer will still produce lags) to trigger <c-space> and wait for
" the first popup after "s." (or manually press <c-space>), this will open
" popup with [O] for "omni" and the results will be cached. Afterwards, press
" "tst" and wait (or manually <c-space>) and the "toString()" result will be
" in the popup.

inoremap <expr><c-space> neocomplete#start_manual_complete()
set completeopt=menuone,noselect

" Autodetected value,to manually disable using it. To check if neovim has
" recognized vimproc: echo neocomplete#has_vimproc()
" let g:neocomplete#use_vimproc

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" disable neocomplete in cygwin/mintty
if exists('$OS') && $OS ==# 'Windows_NT' && &term =~ '^xterm'
	let g:neocomplete#enable_at_startup = 0
endif

" disable automatic completion
let g:neocomplete#disable_auto_complete = 0
" TODO investigate whether it is the same as :NeoCompleteToggle

" When ==1 -> more flicker, gives more correct results, when in autopopup mode.
" It seems like fuzzying is triggered when no candidates whose chars are matched
" consequently are not available. 1 always trigger fuzzying (it seems).
let g:neocomplete#enable_refresh_always = 0

" Use smartcase.
let g:neocomplete#enable_smart_case = 0

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2

" create delay before popup in ms (50 is default)
let g:neocomplete#auto_complete_delay = 500

" let g:neocomplete#skip_auto_completion_time = ''

" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
" 	let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" " TODO check what exactly this does. Must be equivalent to:
" " let g:neocomplete#keyword_patterns._ = '\h\w*'

" if !exists('g:neocomplete#sources')
" 	let g:neocomplete#sources = {}
" endif

" neocomplete + eclim:
" " faq says it does not support eclim out of the box
" " then add one of the 2 following:
" " 1. from documentation(fixed):
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.java = '\%(\h\w*\|)\)\.\w*'

" 2. but others seem to be using this. This may disable fuzzy completion when
" omni source is used.
" if !exists('g:neocomplete#force_omni_input_patterns')
" 	let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_omni_input_patterns.java = '\k\.\k*'

" same as 1, different regex
" " if !exists('g:neocomplete#sources#omni#input_patterns')
" " 	let g:neocomplete#sources#omni#input_patterns = {}
" " endif
" " let g:neocomplete#sources#omni#input_patterns.java = '\h\w*\.\w*'

" " ---------
" TODO: the above will omni complete after "()." but will falsely try to omni
" after "someVar.tst" (note that eclim will not make it into "toString")
" TODO: make manual trigger that will detect pattern "someVar.tst" and will
" delete "tst", press <c-space> to cache omnicompletion, then restore tst and
" present fuzzy results. :h i_ctrl-o, :h getline(), :h append().

" " ---------

" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function_DDD()<CR>
" function! s:my_cr_function_DDD()
"   return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
" endfunction

" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" neocomplete#start_manual_complete([{sources}])
" inoremap <expr><Tab>  neocomplete#start_manual_complete()

" " <C-h>, <BS>: close popup and delete backword char
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" -------------- KAORIYA --------------------------------------------
" REMINDER: always delete the included vimrc AND gvimrc files
if has('kaoriya')
	let g:no_gvimrc_example = 1
	set ambiwidth=auto
	" TODO check for existence vimrc and gvimrc and show error
endif

" ------------ gvimfullscreen-win32 ----------------------------------
if has('win64')
	nnoremap <F11> <Esc>:call libcallnr(expand('$HOME\.vim\plugged\gvimfullscreen_win32\gvimfullscreen_64.dll'), "ToggleFullScreen", 0)<CR>
elseif has('win32')
	nnoremap <F11> <Esc>:call libcallnr(expand('$HOME\.vim\plugged\gvimfullscreen_win32\gvimfullscreen.dll'), "ToggleFullScreen", 0)<CR>
endif

" ---------------- profiling plugins
" https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow
" profile start profile.log | profile func * | profile file *
" " At this point do slow actions
" profile pause
" :qa
" ----------------- debugging autocmd -------------------------------
" While testing autocommands, you might find the 'verbose' option to be useful:
" 	:set verbose=9
" This setting makes Vim echo the autocommands as it executes them.
" -------------------------------------------------------------------
" TODO beautify gutter sign error / warning
" -------------------------------------------------------------------
" TODO find a way to convert input to greek from vim, while still typing ENG
" FIXME
" -------------------------------------------------------------------
" for future fuzzy finder (like ctrlp)
" set wildignore+=*/build/**
