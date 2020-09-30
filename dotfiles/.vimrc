"" ----------------------------------------
""	Plugin
"" ----------------------------------------
let s:plugdir=has('nvim') ? '~/.config/nvim/plugged/' : '~/.vim/plugged'
call plug#begin(s:plugdir)
	Plug 'mattn/emmet-vim'
	Plug 'bfredl/nvim-miniyank'
	Plug 'tpope/vim-commentary'
	Plug 'junegunn/vim-easy-align'
	Plug 'yuttie/comfortable-motion.vim'
	Plug 'bronson/vim-trailing-whitespace'
	Plug 'ConradIrwin/vim-bracketed-paste'
	Plug 'ayu-theme/ayu-vim' | Plug 'dylanaraps/wal.vim'
	Plug 'sheerun/vim-polyglot' | Plug 'ap/vim-css-color'
	Plug 'cohama/lexima.vim' | Plug 'machakann/vim-sandwich'
	Plug 'tpope/vim-fugitive' | Plug 'rhysd/conflict-marker.vim'
	Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
	Plug 'haya14busa/incsearch.vim' | Plug 'haya14busa/incsearch-fuzzy.vim'
	Plug 'Lokaltog/vim-easymotion' | Plug 'haya14busa/incsearch-easymotion.vim'
	Plug 'junegunn/fzf.vim' | Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
call plug#end()

"" ----------------------------------------
""	Configure
"" ----------------------------------------
set nobomb
set lazyredraw
set laststatus=0
set termguicolors
let $LANG='en_US.UTF-8'
let mapleader="\<Space>"
set title titlestring=%F
set splitright splitbelow
set clipboard=unnamedplus
set fileformats=unix,dos,mac
set whichwrap=b,s,h,l,<,>,[,]
set hidden nobackup noswapfile
set smartcase ignorecase wildignorecase
set rulerformat=%40(%1*%=%l,%-(%c%V%)\ %=%t%)%*
set noexpandtab tabstop=4 softtabstop=-1 shiftwidth=0
set encoding=utf-8 fileencodings=cp932,sjis,euc-jp,utf-8,iso-2022-jp
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
if has('nvim')
	set inccommand=split
else
	sy on
	set ttyfast
	set autoread
	set wildmenu
	set belloff=all
	set ruler showcmd
	set hlsearch incsearch
	filetype plugin indent on
	set backspace=indent,eol,start
endif

"" ----------------------------------------
""	Mapping
"" ----------------------------------------
nn Y y$
nn + <C-a>
nn - <C-x>
nn <Up> gk
nn <Down> gj
tno <ESC> <C-\><C-n>
nn <Leader>t :tabnew<CR>
nn <Leader>n :set invnumber<CR>
nn <Leader>1 :diffget LOCAL<CR>
nn <Leader>2 :diffget BASE<CR>
nn <Leader>3 :diffget REMOTE<CR>
nn <Leader>code :!code %:p<CR>
nn <Leader>dir :!code -r %:p:h<CR>
nn <Leader>term :split \| terminal<CR>

"" ----------------------------------------
""	PluginSetting
"" ----------------------------------------
"" ========== Theme ==========
let ayucolor='dark' | colo ayu
hi User1 guifg=#3D424D
hi Normal guibg=#0A0E14
hi ModeMsg guifg=#3D424D
hi FoldColumn guibg=#0A0E14
hi EndOfBuffer ctermfg=0 guifg=bg
hi DiffAdd gui=NONE guifg=NONE guibg=#012800
hi DiffText gui=NONE guifg=NONE guibg=#012800
hi DiffChange gui=NONE guifg=NONE guibg=#012800
hi DiffDelete gui=bold guifg=#340001 guibg=#340001
nn <Leader>wal :set notermguicolors \| colo wal<CR><CR>

"" ========== Fzf ==========
nn <Leader>file :Files<CR>
nn <Leader>hist :History<CR>
nn <Leader>rg :call Rg()<CR>
let g:fzf_layout={'right': '~45%'}
com! -bang -nargs=* History call fzf#vim#history(fzf#vim#with_preview('down:50%'))
com! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview('down:50%'), <bang>0)
fun! Rg()
	let string=input('Search String: ')
	call fzf#run(fzf#wrap({
		\ 'source': 'rg -lin ' . string,
		\ 'options': '--preview-window bottom:60% --preview "rg -in --color=always ' . string . ' {}"'
	\ }))
endfun

"" ========== Emmet ==========
let g:user_emmet_settings = {
	\ 'typescript' : { 'extends' : 'jsx' },
	\ 'javascript.jsx' : { 'extends' : 'jsx' }
\ }

"" ========== VimPlug ==========
nn <Leader>clean :PlugClean<CR>
nn <Leader>install :PlugInstall<CR>
nn <Leader>update :PlugUpgrade \| PlugUpdate<CR>

"" ========== Coc.nvim ==========
let g:coc_config_home = "~/.config/coc"
let g:coc_global_extensions = [
      \ 'coc-go',
      \ 'coc-sh',
      \ 'coc-css',
      \ 'coc-sql',
      \ 'coc-rls',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-perl',
      \ 'coc-vimlsp',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-prettier',
      \ 'coc-tsserver',
      \ 'coc-markdownlint',
\ ]
hi CocInfoLine guifg=None guibg=#012800
hi CocHintLine guifg=None guibg=#012800
hi CocErrorLine guifg=None guibg=#340001
hi CocWarningLine guifg=None guibg=#525200
nn <Leader>cls :CocList<CR>
nn <Leader>cupd :CocUpdate<CR>
nn <Leader>cdis :CocDisable<CR>
nm <silent> <Leader>cfmt <Plug>(coc-format)
nm <silent> <Leader>cref <Plug>(coc-reference)
nm <silent> <Leader>cdef <Plug>(coc-definition)
nm <silent> <Leader>cfix <Plug>(coc-fix-current)
nm <silent> <Leader>cn <Plug>(coc-diagnostic-next)
nm <silent> <Leader>cp <Plug>(coc-diagnostic-prev)
ino <expr> <UP> pumvisible() ? '<C-e><UP>' : '<UP>'
ino <expr> <DOWN> pumvisible() ? '<C-e><DOWN>' : '<DOWN>'
fun! TabComp()
	if pumvisible()
		return "\<C-n>"
	elseif coc#jumpable()
		return "\<C-r>=coc#rpc#request('snippetNext',[])\<CR>"
	else
		return "\<Tab>"
	endif
endfun
im <expr> <Tab> TabComp() | smap <expr> <Tab> TabComp()
fun! TabShiftComp()
	if pumvisible()
		return "\<C-p>"
	elseif coc#jumpable()
		return "\<C-r>=coc#rpc#request('snippetPrev',[])\<CR>"
	else
		return "\<S-Tab>"
	endif
endfun
im <expr> <S-Tab> TabShiftComp() | smap <expr> <S-Tab> TabShiftComp()

"" ========== Polyglot ==========
let g:polyglot_excludes = ['csv']

"" ========== EasyAlign ==========
xm ga <Plug>(LiveEasyAlign)
nm ga <Plug>(LiveEasyAlign)

"" ========== EasyMotion ==========
let g:EasyMotion_do_mapping=0
let g:EasyMotion_enter_jump_first=1
map <Leader>s <Plug>(easymotion-sn)
fun! s:config_easyfuzzymotion(...) abort
	return extend(copy({
		\ 'converters': [incsearch#config#fuzzyword#converter()],
		\ 'modules': [incsearch#config#easymotion#module({'overwin': 1})],
		\ 'keymap': {"\<CR>": '<Over>(easymotion)'},
		\ 'is_expr': 0,
		\ 'is_stay': 1
	\ }), get(a:, 1, {}))
endfun
no <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

"" ========== VimFugitive ==========
set diffopt+=vertical
nn <Leader>gd :Gdiff<CR>
nn <Leader>ga :Gwrite<CR>
nn <Leader>gb :Gblame<CR>
nn <Leader>gs :Gstatus<CR>
nn <Leader>du :diffupdate<CR>
nn <Leader>gm :Gdiffsplit!<CR>
nn <Leader>dp :diffput 1 \| diffupdate<CR>
nn <Leader>dgl :diffget //2 \| diffupdate<CR>
nn <Leader>dgr :diffget //3 \| diffupdate<CR>

"" ========== NvimMiniyank ==========
if has("nvim")
	map p <Plug>(miniyank-autoput)
	map P <Plug>(miniyank-autoPut)
endif

"" ========== ConflictMarker ==========
let g:conflict_marker_end = '^>>>>>>> .*$'
let g:conflict_marker_begin = '^<<<<<<< .*$'
hi ConflictMarkerEnd guibg=#2f628e
hi ConflictMarkerOurs guibg=#2e5049
hi ConflictMarkerBegin guibg=#2f7366
hi ConflictMarkerTheirs guibg=#344f69
hi ConflictMarkerCommonAncestorsHunk guibg=#754a81

"" ========== VimTrailingSpace ==========
nn <Leader>trim :FixWhitespace<CR>
