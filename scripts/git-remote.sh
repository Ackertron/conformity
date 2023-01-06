function git-remote {
  git checkout master
  git fetch origin $1
  git checkout $1
}