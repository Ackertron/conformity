#conformity
alias conformity="source $(pwd)/conformity.sh"

#k8s
#install kube-ps1 via https://github.com/jonmosco/kube-ps1
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
alias k8s_context='PS1="$(kube_ps1)"$PS1'

#git
alias oops='git commit -am "oops" && git rebase -i HEAD~2 && git push --force origin $(git rev-parse --abbrev-ref HEAD)'
alias git-master='git checkout master && git rebase origin master'