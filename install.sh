#!/bin/sh

#install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install zsh
brew install vim --with-lua

#set dotfiles
cd $(dirname $0)

for dotfile in .?*
do
    if [ $dotfile != ".." ] && [ $dotfile != ".git" ] && [ $dotfile != ".gitmodules" ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done

mkdir -p ~/.vim/rc/
ln -s ~/dotfiles/dein.toml ~/.vim/rc/dein.toml
ln -s ~/dotfiles/dein_lazy.toml ~/.vim/rc/dein_lazy.toml

git config --global core.excludesfile ~/dotfiles/.gitignore

brew install fzf
brew install the_silver_searcher

# go setting
brew install go

mkdir -p ~/go/bin ~/go/pkg ~/go/src
echo "export GOPATH=$HOME/go" >> ~/.zshrc
echo "export PATH=$GOPATH/bin:$PATH" >> ~/.zshrc

go get -u github.com/golang/dep/cmd/dep

brew install protobuf
go get -u google.golang.org/grpc
go get -u github.com/golang/protobuf/proto
go get -u github.com/golang/protobuf/protoc-gen-go
go get -u go.pedge.io/protoeasy/cmd/protoeasy
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/kisielk/errcheck
go get -u golang.org/x/lint/golint
go get -u github.com/client9/misspell/cmd/misspell
go get -u github.com/sourcegraph/go-langserver

#vim setting
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
