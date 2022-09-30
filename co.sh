#!/bin/sh

branch=$1
if test -n "$(git branch -a --format="%(refname:short)" | grep -e ^$branch$)"; then
  git checkout $branch
  exit 0
fi

branch="feature/$1"
if test -n "$(git branch -a --format="%(refname:short)" | grep -e ^$branch$)"; then
  git checkout $branch
  exit 0
fi

branch="fix/$1"
if test -n "$(git branch -a --format="%(refname:short)" | grep -e ^$branch$)"; then
  git checkout $branch
  exit 0
fi

branch="hotfix/$1"
if test -n "$(git branch -a --format="%(refname:short)" | grep -e ^$branch$)"; then
  git checkout $branch
  exit 0
fi

echo "branch $1 not exist"
