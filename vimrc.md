
# base setting

## 全般

- swapファイルを作らない
```
set noswapfile
```
- カーソル位置表示
```
set ruler
```
- コマンド部分の高さ
```
set cmdheight=2
```
- ステータスバーの表示条件 2:ステータスバーを常時表示する
```
set laststatus=2
```
- ウィンドウのタイトルバーにファイル名を表示。CLI上だと意味ない？
```
set title
```
- 入力中のコマンドを右下に表示
```
set showcmd
```
- 入力中のコマンド表示だが出てない？
```
set showcmd
```
- modelineオプションを無効にする
  - 意図しないコマンドを実行されるCVE-2007-2438の対策も兼ねる
```
set modelines=0
```

## インデント関連

```
set autoindent
set smartindent
set tabstop=4
set shiftwidth=2
set smarttab
set expandtab
filetype plugin on
filetype indent on
```

# キーマップ

## 参考サイト

- [mapとnoremapの違い](https://cocopon.me/blog/2013/10/vim-map-noremap/)
- [Vim のカスタマイズ 〜キー割り当て変更方法〜](https://vimblog.hatenablog.com/entry/vimrc_key_mapping)
- [vimでキーマッピングする際に考えたほうがいいこと](https://deris.hatenablog.jp/entry/2013/05/02/192415)
- [俺的にはずせない【Vim】こだわりのmap（説明付き）](https://qiita.com/itmammoth/items/312246b4b7688875d023)

## 全般
- Leaderキー<Leader>をスペースに設定
```
let mapleader = "\<Space>"
```
- jkでインサートモードを抜ける
```
inoremap jk <esc>
```
- ssでファイル保存
```
nnoremap ss :<C-u>update<CR>
```
- バッファ一覧表示
```
nmap bf :ls<CR>:buf
```

- 表示行単位の移動にする
```
noremap j gj
noremap k gk
```
- Shiftを押しながら移動で、行単位移動
```
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $
```
- 保存して閉じる、保存せず閉じる、EXモードに入るのを防ぐ
```
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
jnnoremap Q <Nop>
```

- スペース二回でカーソル下の単語をハイライトする
```
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
```

- アスタリスク二回でカーソル下の文字列をハイライトする
```
nnoremap <silent> ** "zyiw:let @/ =  @z <CR>:set hlsearch<CR>
```
- シャープでカーソル下の単語を置換する
```
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>
```
- Yでその行をコピー
```
nnoremap Y y$
```
- yaでファイル全体をコピー

```
nnoremap ya :%y<CR>
```

- Shift+Enter,Shift+Ctrl+Enterで上下に改行追加
  - 下四つはterminal上で動かすための設定
```
imap <S-CR> <End><CR>
imap <C-S-CR> <Home><CR><Up>
nnoremap <S-CR> mzo<ESC>`z
nnoremap <C-S-CR> mzO<ESC>`z
map ✠ <S-CR>
imap ✠ <S-CR>
map ✢ <C-S-CR>
imap ✢ <C-S-CR>
```

# vimrcの編集

- <Space>evでvimrcの編集
- <Space>rvでvimrcの再読み込み

```
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>
```

# dein.vimの動作設定

```
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
```

# 表示に関する設定

## statusline

```
 set statusline=%<%f\%{fugitive#statusline()}\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
```

- fugitiveのステータスライン
```
%<%f\%{fugitive#statusline()}\ 
```

```
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
```

## Airline

```
set laststatus=2
set showtabline=2 " 常にタブラインを表示
set t_Co=256 " この設定がないと色が正しく表示されない
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='papercolor' "落ち着いた色調が好き
let g:airline_powerline_fonts = 1
```
# syntastic

```
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck','misspell']
```

# vimfiler 

- vimデフォルトのエクスプローラをvimfilerで置き換える
```
let g:vimfiler_as_default_explorer = 1
```

- セーフモードを無効にした状態で起動する
```
let g:vimfiler_safe_mode_by_default = 0
```

- <Leader>fe で現在開いているバッファのディレクトリを開く
```
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
```
- <Leader>fi で現在開いているバッファをIDE風に開く

```
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
```

# ctags 設定

```
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
```

# ack.vim 設定

```
let g:ackprg = 'ag --nogroup --nocolor --column'
nmap ;m :Ack!<space>

```
# window関連

## 参考サイト

-[vim キー再割当てしてみる](http://sunmoonnotes.blog.fc2.com/blog-entry-93.html)

## 設定

- sには何も割り振らない
```
nnoremap s <Nop>
```
- ウィンドウ移動
```
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
```
- ウィンドウ配置移動
```
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
```
- タブ新規作成
```
nnoremap st :<C-u>tabnew<CR>
```
- タブ移動
```
nnoremap sn gt
nnoremap sp gT
```
- 高さと幅を揃える

```
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
```

- 高さと幅の調整
```
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
```
- バッファ移動
```
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
```
- 垂直分割
```
nnoremap sv :<C-u>vs<CR>
```
- ウィンドウを閉じる
```
nnoremap sq :<C-u>q<CR>
```
- バッファを閉じる
```
nnoremap sQ :<C-u>bd<CR>
```

# fzf設定

## 参考サイト

- [fzfを使おう](https://qiita.com/kompiro/items/a09c0b44e7c741724c80)
曖昧検索ができる。

## 設定

- ;bでバッファ検索
- ;fでファイル検索
- ,;でファイル内検索

```
set rtp+=/usr/local/opt/fzf
nmap ;b :Buffers<CR>
nmap ;f :Files<CR>
"nmap r :Tags<CR>
nmap ,; :Ag<CR>
```

# git setting

## fugitive-vim
- <leader>gs:ステータス表示
- <leader>ga:git add
- <leader>gcm: git commit -v
- <leader>go: git checkout
- <leader>gb: git checkout -b
- <leader>gbl: git blame
- <leader>gd: git diff
- <leader>gm: git mergbe
- <leader>gps: git push
- <leader>gpl: git pull
- <leader>gbr: git branch

```
nnoremap <silent> [fugitive]s :G status<CR>
nnoremap <silent> [fugitive]a :Gwrite<CR>
nnoremap <silent> [fugitive]cm :G commit-v<CR>
nnoremap          [fugitive]co :G checkout 
nnoremap          [fugitive]cb :G checkout -b 
nnoremap <silent> [fugitive]bl :Gblame<CR>
nnoremap <silent> [fugitive]d :Gdiff<CR>
nnoremap <silent> [fugitive]m :Gmerge<CR>
nnoremap <silent> [fugitive]ps :G push<CR>
nnoremap <silent> [fugitive]pl :G pull<CR>
nnoremap <silent> [fugitive]br :G branch<CR>
```

## vim-gitgutter

- テキストラインで追加は青、変更は黄色、削除は赤で表示

```
hi GitGutterAdd    guifg=#009900 ctermfg=2
hi GitGutterChange guifg=#bbbb00 ctermfg=3
hi GitGutterDelete guifg=#ff2222 ctermfg=1
```

## テスト

主にGoのテスト用

```
let test#strategy = "dispatch"
let test#go#runner = 'gotest'

nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tv :TestVisit<CR>
```

# ファイルタイプ別設定

- HTML

```
au FileType html setlocal sw=2 sts=2 ts=4 et
```

- PHP

```
au FileType php setlocal sw=4 sts=4 ts=4 et
```
- C++

```
au FileType cpp setlocal sw=4 sts=4 ts=4 et
autncmd FileType cpp ClangFormatAutoEnable
```

# lsp
## 参考サイト
- [Vim をモダンな IDE に変える LSP の設定](https://mattn.kaoriya.net/software/vim/20191231213507.htm)

## 設定
- gd:定義ジャンプ
- gi:実装ジャンプ
- <Leader>rn :リネーム
- <Leader>d :型定義ジャンプ
- <Leader>rf :リファレンス確認

```
nmap <buffer> gd <plug>(lsp-definition)
nmap <buffer> gi <plug>(lsp-implementation)
nmap <buffer> <Leader>rn <plug>(lsp-rename)
nmap <buffer> <Leader>d <plug>(lsp-type-definition)
nmap <buffer> <Leader>rf <plug>(lsp-references)
inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
```

```
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_text_edit_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_diagnostics_float_cursor = 1
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
```

# 補完、スニペット

## 参考サイト

- [新世代の自動補完プラグイン ddc.vim](https://zenn.dev/shougo/articles/ddc-vim-beta)
- [ddc.vimとBuiltin LSPでサブ武器を錬成した](https://riq0h.jp/2021/09/15/084023/)
- [Vimの補完を他エディタやIDEのような挙動にするようにする](https://note.com/yasukotelin/n/na87dc604e042)

## ddc.vim
```
 call ddc#custom#patch_global('sources', ['vim-lsp', 'around', 'vsnip'])
 call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \ 'matchers': ['matcher_head'],
      \ 'sorters': ['sorter_rank'],
      \ 'converters': ['converter_remove_overlap'],
      \ },
      \ 'around': {'mark': 'A'},
      \ 'vim-lsp': {
      \ 'mark': 'L',
      \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \ },
      \ })

 call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

 inoremap <silent><expr> <TAB>
      \ ddc#map#pum_visible() ? '<C-n>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()
 inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
 inoremap <expr><cr> ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

 call ddc#enable()

```

- 補完時に表示されるプレビューウィンドウを消す 
  - [Vim - 補完時に表示されるプレビューウィンドウを消す](https://kannokanno.hatenablog.com/entry/2013/05/08/110557)
```
set completeopt+=menuone
```

## スニペット

- C-yでvsnip展開、スペース、Shift+スペースで前後移動

```
imap <expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
smap <expr> <C-y> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-y>'
imap <expr> <space> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<space>'
smap <expr> <space> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<space>'
imap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>'
smap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>'
```

- C-uでultisnip展開、スペース、Shift+スペースで前後移動

```
let g:UltiSnipsExpandTrigger="<C-u>"
let g:UltiSnipsJumpForwardTrigger="<space>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
```

# vim-terraform

```
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1
```

# quickrun

```
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
```

