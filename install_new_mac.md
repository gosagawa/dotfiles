# 概要
Macを変えた際にやる事のメモ

# やる事

## 環境まわり
- トラックパッドの移動速度を最大にする
- キーボードから、キーのリピートを最大にする
```
 defaults write -g InitialKeyRepeat -int 10
 defaults write -g KeyRepeat -int 1
```
- 1Password.comにログイン
- icloudにログイン
- spotlightを開き、ショートカットを無効にする
- AlfredをWebからインストール
  - Alfredのショートカットをcommand+spaceにする
- 1Password.comをインストールする
- chromeをインストール、同期する
- deckを非表示にする
```
defaults write com.apple.Dock autohide-delay -float 10; killall Dock
```
- キーボードに日本語追加
- Karabinerをインストール、日本語入力の設定
  - https://qiita.com/daichi87gi/items/ded35e9d9a54c8fcb9d6
- Touch barをカスタマイズ、Sleep追加
- 壁紙を無しにする

## アプリ類のインストールとカスタマイズ
- インストールするアプリ一式をインストール
- sshキーを設置
- dotfilesをクローン
- shellをbashからzshに変える
- iTerm2の設定
  - 背景を透過にする
- install.shを流す
- powerline用のフォント設定
  - https://qiita.com/nakajiki/items/485c24977f4172761cdf
  - DejaVu Sans Mono for Powerline
- .gitconfigに以下追加
```
[user]
    name = Go Sagawa
    email = ***メールアドレス***
[include]
    path = ***ホームのパス***/dotfiles/.gitconfig
```
- office一式をインストール
- vimで以下コマンド実行
```
:GoUpdateBinaries
```

# インストールするアプリ
- firefox
- docker
- kindle
- FileZilla
- chatwork
- Sequel Pro
- postman
- iterm2
- kiteatic
- HarooPad
- git
- slack
- CyberDuck
