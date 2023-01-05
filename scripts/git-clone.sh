#!/bin/bash

function git-clone {
  echo "git@github.com:$GITHUB_ORG/$1.git"
  git clone git@github.com:$GITHUB_ORG/$1.git
  cd $1
}
