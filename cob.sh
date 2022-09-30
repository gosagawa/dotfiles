#!/bin/sh

p=$1
branch=$2

prefix=""

if [ $p == "fe" ]; then
  prefix="feature"
fi
if [ $p == "fi" ]; then
  prefix="fix"
fi
if [ $p == "h" ]; then
  prefix="hotfix"
fi
if [ -z "$prefix" ]; then
  echo "wrong prefix. Choose [fe]feature [fi]fix [h]hotfix"
else
  git checkout -b $prefix/$branch
fi
