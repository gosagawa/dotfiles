
# base setting

## 全般
- set noswapfile
swapファイルを作らない

- set ruler
カーソル位置表示

- set cmdheight=2
コマンド部分の高さ

- set laststatus=2
ステータスバーの表示条件 2:ステータスバーを常時表示する

- set title
ウィンドウのタイトルバーにファイル名を表示。CLI上だと意味ない？

- set showcmd
入力中のコマンドを右下に表示

- set showcmd
入力中のコマンド表示だが出てない？

- set modelines=0
modelineオプションを無効にする
意図しないコマンドを実行されるCVE-2007-2438の対策も兼ねる


## インデント関連


## statusline

```
 set statusline=%<%f\%{fugitive#statusline()}\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
```

- %<%f\%{fugitive#statusline()}\ 
fugitiveのステータスライン

# キーマップ

## メモ

- mapとnoremapの違い
https://cocopon.me/blog/2013/10/vim-map-noremap/

- Vim のカスタマイズ 〜キー割り当て変更方法〜
https://vimblog.hatenablog.com/entry/vimrc_key_mapping

- vimでキーマッピングする際に考えたほうがいいこと
https://deris.hatenablog.jp/entry/2013/05/02/192415

- 俺的にはずせない【Vim】こだわりのmap（説明付き）
https://qiita.com/itmammoth/items/312246b4b7688875d023

## 全般
- let mapleader = "\<Space>"
Leaderキー<Leader>をスペースに設定

- inoremap jk <esc>
jkでインサートモードを抜ける

- nnoremap ss :<C-u>update<CR>
ssでファイル保存

- nmap bf :ls<CR>:buf
バッファ一覧表示

- noremap j gj
- noremap k gk
表示行単位の移動にする

- noremap <S-h>   ^
- noremap <S-j>   }
- noremap <S-k>   {
- noremap <S-l>   $
Shiftを押しながら移動で、行単位移動

- nnoremap ZZ <Nop>
- nnoremap ZQ <Nop>
- jnnoremap Q <Nop>
保存して閉じる、保存せず閉じる、EXモードに入るのを防ぐ

- nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
スペース二回でカーソル下の単語をハイライトする

- nnoremap <silent> ** "zyiw:let @/ =  @z <CR>:set hlsearch<CR>
アスタリスク二回でカーソル下の文字列をハイライトする

- nmap # <Space><Space>:%s/<C-r>///g<Left><Left>
シャープでカーソル下の単語を置換する

- nnoremap Y y$
Yでその行をコピー

- nnoremap ya :%y<CR>
yaでファイル全体をコピー

