alias lc="wc -l"
alias keepass="nohup mono ~/opt/KeePass-2.40/KeePass.exe&"
alias pstorm="nohup phpstorm &"
squash () {
    GIT_SEQUENCE_EDITOR=true bash -c "git rebase -i --autosquash HEAD~$1"
}
set_deploy_test_ip () {
    remove_test_ip
    for host in `wget -qO- http://smithers.wizacha.com/deployTestTargets`
    do
        echo "$1 $host #deploy_test" | sudo tee --append /etc/hosts > /dev/null
    done
}
remove_test_ip () {
    sudo sed -i '/#deploy_test$/d' /etc/hosts
}
git_clean () {
    git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d
}
deploy_marketplace () {
    git fetch origin && git co origin/master && git tag $1 && git push origin $1
}
gcb_from_master () {
    git fetch origin && git checkout -B $1 origin/master
}

