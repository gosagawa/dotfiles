
"--------------------------------------------------------------------------
" base setting

set noswapfile
set ruler
set cmdheight=2
set laststatus=2
set title
set showcmd

" indent
set autoindent
set smartindent
set tabstop=4
set shiftwidth=2
set smarttab
set expandtab
filetype plugin on
filetype indent on

syntax on
colorscheme desert

set clipboard&
set clipboard+=unnamed

" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup
set backupcopy=yes

set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set fileformats=unix,dos,mac

"--------------------------------------------------------------------------
" base key map
let mapleader = "\<Space>"
inoremap jk <esc>
nnoremap ss :<C-u>update<CR>
nmap bf :ls<CR>:buf

" move cursol
noremap j gj
noremap k gk
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $

" not using
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" search,convert
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nnoremap <silent> ** "zyiw:let @/ =  @z <CR>:set hlsearch<CR>
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>

" search,convert
nnoremap Y y$
nnoremap ya :%y<CR>

" add empty line
imap <S-CR> <End><CR>
imap <C-S-CR> <Home><CR><Up>
nnoremap <S-CR> mzo<ESC>`z
nnoremap <C-S-CR> mzO<ESC>`z
map ✠ <S-CR>
imap ✠ <S-CR>
map ✢ <C-S-CR>
imap ✢ <C-S-CR>

"--------------------------------------------------------------------------
" operator-camelize

map <Leader>c <plug>(operator-camelize-toggle)

"--------------------------------------------------------------------------
"vimrc reedit setting
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

augroup MyAutoCmd
    autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC |
                \if has('gui_running') | source $MYGVIMRC
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif

"--------------------------------------------------------------------------
"dein setting
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" install dein.vim if not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" setting start
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " setting TOML files
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " read TOML and cache
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  "setting finish
  call dein#end()
  call dein#save_state()
endif

call map(dein#check_clean(), "delete(v:val, 'rf')")

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"--------------------------------------------------------------------------
"display setting

set statusline=%<%f\%{fugitive#statusline()}\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set number
set autoindent
set incsearch
set hlsearch
set showmatch

set clipboard=unnamed,autoselect

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" 全角スペース・行末のスペース・タブの可視化
if has("syntax")
    syntax on

    " PODバグ対策
    syn sync fromstart

    function! ActivateInvisibleIndicator()
        " 下の行の"　"は全角スペース
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
        "syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        "highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
        "syntax match InvisibleTab "\t" display containedin=ALL
        "highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
    endfunction

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

"Airline
set laststatus=2
set showtabline=2 " 常にタブラインを表示
set t_Co=256 " この設定がないと色が正しく表示されない
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='papercolor' "落ち着いた色調が好き
let g:airline_powerline_fonts = 1

"--------------------------------------------------------------------------
" syntastic
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck','misspell']

"--------------------------------------------------------------------------
"ddu.vim

let win_border = 'rounded'
let win_height = '&lines - 3'
let win_width = '&columns / 2 - 3'
let win_col = 1
let win_row = 0
let preview_row = 3
let preview_col = '&columns / 2'

call ddu#custom#patch_global({
\	'ui': 'ff',
\	'uiParams': {
\		'ff': {
\			'ignoreEmpty': v:true,
\			'split': 'floating',
\			'startAutoAction': v:true,
\			'autoAction': { 'name': 'preview', 'delay': 0, },
\			'prompt': '> ',
\			'startFilter': v:true,
\			'filterSplitDirection': 'floating',
\			'filterFloatingPosition': 'top',
\			'floatingBorder': win_border,
\			'winHeight': win_height,
\			'winWidth': win_width,
\			'winRow': win_row,
\			'winCol': win_col,
\			'previewFloating': v:true,
\			'previewFloatingBorder': win_border,
\			'previewHeight': win_height,
\			'previewWidth': win_width,
\			'previewRow': preview_row,
\			'previewCol': preview_col,
\		},
\		'filer': {
\			'winWidth': 40,
\			'split': 'vertical',
\			'splitDirection': 'topleft',
\			'sort': 'filename',
\			'sortTreesFirst': v:true,
\		},
\	},
\	'sourceOptions': {
\		'_': {
\			'matchers': ['matcher_fzf'],
\			'sorters': ['sorter_fzf'],
\			'ignoreCase': v:true,
\		},
\		'file': {
\			'columns': ['icon_filename'],
\		},
\		'line': {
\			'sorters': [],
\		},
\	},
\	'filterParams': {
\		'matcher_fzf': {
\			'highlightMatched': 'Search',
\		},
\	},
\	'kindOptions': {
\		'file': {
\			'defaultAction': 'open',
\		},
\		'word': {
\			'defaultAction': 'append',
\		},
\	},
\	'actionOptions': {
\		'narrow': {
\			'quit': v:true,
\		},
\	},
\})

call ddu#custom#patch_local('file_rec', {
\	'sources': [{
\		'name':'file_rec',
\		'params': {
\			'ignoredDirectories': ['.git', 'var', 'node_modules', ]
\		},
\	}],
\})

call ddu#custom#patch_local('filer', {
\	'ui': 'filer',
\	'sources': [
\		{'name': 'file', 'params': {}},
\	],
\	'resume': v:true,
\ })

call ddu#custom#patch_local('grep', {
\	'sourceParams' : {
\		'rg' : {
\			'args': ['--column', '--no-heading', '--color', 'never', '-i'],
\		},
\	 },
\	'uiParams': {
\		'ff': {
\			'startFilter': v:false,
\		 }
\	 },
\	'resume': v:true,
\ })

nnoremap <Leader>b <Cmd>Ddu buffer -ui-param-ff-startFilter=v:false<CR>
nnoremap <Leader>o <Cmd>Ddu line<CR>
nnoremap <Leader>r <Cmd>Ddu register -ui-param-ff-startFilter=v:false<CR>
nnoremap <Leader>e <Cmd>Ddu -name=file_rec<CR>
nnoremap <Leader>g <Cmd>Ddu rg -name=grep -source-param-rg-input='`'Pattern: '->input('<cword>'->expand())`'<CR>
nnoremap <C-g> <Cmd>Ddu -name=grep<CR>
nnoremap <C-n> <Cmd>call ddu#ui#multi_actions(['cursorNext', 'itemAction'], 'grep')<CR>
nnoremap <C-p> <Cmd>call ddu#ui#multi_actions(['cursorPrevious', 'itemAction'], 'grep')<CR>

"--------------------
" FF
"--------------------
autocmd FileType ddu-ff call s:ddu_ff_settings()
function! s:ddu_ff_settings() abort
	nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
	nnoremap <buffer><silent> s <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
	nnoremap <buffer><silent> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
	nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
	nnoremap <buffer><silent> <C-g> <Cmd>call ddu#ui#do_action('quit')<CR>
endfunction
autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
	inoremap <buffer> <C-n> <Nop>
	inoremap <buffer> <C-p> <Nop>
	nnoremap <buffer> <CR> :q<CR>
	nnoremap <buffer> q :q<CR>
	inoremap <buffer> <CR> <ESC>:q<CR>
	inoremap <buffer> jj <ESC>:q<CR>
	inoremap <buffer> jk <ESC>:q<CR>
	inoremap <buffer> kj <ESC>:q<CR>
	inoremap <buffer> kk <ESC>:q<CR>
endfunction

"--------------------
" Filer
"--------------------

nnoremap <Leader>fi <Cmd>call ddu#start({
\   'name': 'filer',
\   'searchPath': expand('%:p'),
\ })<CR>

autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort

	nnoremap <buffer><silent> hd
	\ <Cmd>call ddu#ui#do_action('updateOptions', #{
	\   sourceOptions: #{
	\     _: #{
	\       matchers: ToggleHidden(),
	\     },
	\   },
	\ })<CR>
	\<Cmd>call ddu#ui#do_action('redraw')<CR>
	

	nnoremap <buffer><silent><expr> <CR>
	\	ddu#ui#get_item()->get('isTree', v:false) ?
	\	"<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR>" :
	\	"<Cmd>call ddu#ui#do_action('itemAction')<CR>"

	nnoremap <buffer><silent> ..
	\	<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow','params': {'path': '..'}})<CR>

	nnoremap <buffer><silent> h <Cmd>call ddu#ui#do_action('collapseItem')<CR>
	nnoremap <buffer><silent> l <Cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<CR>
	nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
	nnoremap <buffer><silent> cp <Cmd>call ddu#ui#do_action('itemAction', {'name': 'copy'})<CR>
	nnoremap <buffer><silent> p <Cmd>call ddu#ui#do_action('itemAction', {'name': 'paste'})<CR>
	nnoremap <buffer><silent> dd <Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>
	nnoremap <buffer><silent> r <Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>
	nnoremap <buffer><silent> mv <Cmd>call ddu#ui#do_action('itemAction', {'name': 'move'})<CR>
	nnoremap <buffer><silent> n <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>
	nnoremap <buffer><silent> mk <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>
	nnoremap <buffer><silent> yy <Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>
endfunction

function ToggleHidden()
  const current = ddu#custom#get_current(b:ddu_ui_name)
  const source_options = get(current, 'sourceOptions', {})
  const source_options_all = get(source_options, '_', {})
  const matchers = get(source_options_all, 'matchers', [])
  return empty(matchers) ? ['matcher_hidden'] : []
endfunction

"--------------------------------------------------------------------------
"ctags setting
set tags=./.tags;$HOME
nnoremap <C-]> g<C-]>

function! s:execute_ctags() abort
  " 探すタグファイル名
  let tag_name = '.tags'
  " ディレクトリを遡り、タグファイルを探し、パス取得
  let tags_path = findfile(tag_name, '.;')
  " タグファイルパスが見つからなかった場合
  if tags_path ==# ''
    return
  endif

  " タグファイルのディレクトリパスを取得
  " `:p:h`の部分は、:h filename-modifiersで確認
  let tags_dirpath = fnamemodify(tags_path, ':p:h')
  " 見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
  execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
endfunction

augroup ctags
  autocmd!
  autocmd BufWritePost * call s:execute_ctags()
augroup END

"--------------------------------------------------------------------------
"ack.vim setting

let g:ackprg = 'ag --nogroup --nocolor --column'
nmap ;m :Ack!<space>

"--------------------------------------------------------------------------
"window movement

nnoremap s <Nop>

nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=

nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>

nnoremap sv :<C-u>vs<CR>
nnoremap sp :<C-u>sp<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

"--------------------------------------------------------------------------
" fzf setting
set rtp+=/usr/local/opt/fzf
nmap ;b :Buffers<CR>
nmap ;f :Files<CR>
"nmap r :Tags<CR>
nmap ,; :Ag<CR>

"--------------------------------------------------------------------------
"git setting
nnoremap [fugitive]  <Nop>
nmap <leader>g [fugitive]
nnoremap <silent> [fugitive]s :G status<CR>
nnoremap <silent> [fugitive]a :Gwrite<CR>
nnoremap <silent> [fugitive]cv :G commit -v<CR>
nnoremap          [fugitive]cm :G commit -a -m ""<Left>
nnoremap          [fugitive]co :G checkout 
nnoremap          [fugitive]cb :G checkout -b 
nnoremap <silent> [fugitive]b :G blame<CR>
nnoremap <silent> [fugitive]d :Gdiff<CR>
nnoremap <silent> [fugitive]m :Gmerge<CR>
nnoremap <silent> [fugitive]ps :G push<CR>
nnoremap <silent> [fugitive]pl :G pull<CR>
nnoremap <silent> [fugitive]br :G branch<CR>

hi GitGutterAdd    guifg=#009900 ctermfg=2
hi GitGutterChange guifg=#bbbb00 ctermfg=3
hi GitGutterDelete guifg=#ff2222 ctermfg=1

"--------------------------------------------------------------------------
" test setting
let test#strategy = "dispatch"
let test#go#runner = 'gotest'

nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tv :TestVisit<CR>

"--------------------------------------------------------------------------
"html setting

au FileType html setlocal sw=2 sts=2 ts=4 et

"--------------------------------------------------------------------------
"php setting

au FileType php setlocal sw=4 sts=4 ts=4 et

"--------------------------------------------------------------------------
"cpp setting

au FileType cpp setlocal sw=4 sts=4 ts=4 et
autocmd FileType cpp ClangFormatAutoEnable

"--------------------------------------------------------------------------
"lsp

if empty(globpath(&rtp, 'autoload/lsp.vim'))
  finish
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> <Leader>rn <plug>(lsp-rename)
  nmap <buffer> <Leader>d <plug>(lsp-type-definition)
  nmap <buffer> <Leader>rf <plug>(lsp-references)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 500
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_insert_mode_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_highlights_insert_mode_enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_text_edit_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']

let g:lsp_settings = {}
let g:lsp_settings['gopls'] = {
  \  'workspace_config': {
  \    'usePlaceholders': v:true,
  \    'analyses': {
  \      'fillstruct': v:true,
  \    },
  \  },
  \  'initialization_options': {
  \    'usePlaceholders': v:true,
  \    'analyses': {
  \      'fillstruct': v:true,
  \    },
  \  },
  \}


"--------------------------------------------------------------------------
" ddc.vim

call ddc#custom#patch_global('ui', 'native')

call ddc#custom#patch_global('sources', ['vim-lsp', 'around'])
" call ddc#custom#patch_global('sources', ['vim-lsp', 'around', 'vsnip'])
call ddc#custom#patch_global('sourceOptions', {
      \   '_': {
      \     'matchers': ['matcher_head'],
      \     'sorters': ['sorter_rank'],
      \     'converters': ['converter_remove_overlap'],
      \   },
      \   'around': {'mark': 'A'},
      \   'vim-lsp': {
      \     'mark': 'L',
      \     'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \   },
      \   'vsnip': {
      \     'mark': 'vsnip',
      \   },
      \ })

call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

" inoremap <silent><expr> <TAB>
"       \ ddc#map#pum_visible() ? '<C-n>' :
"       \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"       \ '<TAB>' : ddc#map#manual_complete()
" inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
" inoremap <expr><cr> ddc#map#pum_visible() ? '<C-y>' : '<cr>'

call ddc#enable()

set completeopt+=menuone


"--------------------------------------------------------------------------
" snippet

" vsnip
imap <expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
smap <expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
imap <expr> <space> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<space>'
smap <expr> <space> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<space>'
imap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>'
smap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>'
let g:vsnip_filetypes = {}

" ultisnips
let g:UltiSnipsExpandTrigger="<C-u>"
let g:UltiSnipsJumpForwardTrigger="<space>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"--------------------------------------------------------------------------
" vim-terraform

let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

"--------------------------------------------------------------------------
" quickrun

let g:quickrun_config = get(g:, 'quickrun_config', {})

let g:quickrun_config._ = {
\   'runner'    : 'vimproc',
\   'runner/vimproc/updatetime' : 60,
\   'outputter' : 'error',
\   'outputter/error/success' : 'buffer',
\   'outputter/error/error'   : 'quickfix',
\   'outputter/buffer/split'  : ':rightbelow 8sp',
\   'outputter/buffer/close_on_empty' : 1,
\}

let g:quickrun_config["gobuild"] = {
\   'command': 'go',
\   'cmdopt' : './...',
\   'exec': '%c build %o',
\}

let g:quickrun_config["goerrcheck"] = {
\   'command': 'errcheck',
\   'cmdopt' : '-blank -ignoretests ./...',
\   'exec': '%c %o',
\}

 " autocmd BufWritePost *.go :QuickRun gobuild
 " autocmd BufWritePost *.go :QuickRun goerrcheck
