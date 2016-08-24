alias lc="wc -l"
squash () {
    git rebase -i --autosquash HEAD~$1
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
    git fetch --all && git co origin/master && git merge --no-ff origin/stage -m 'Merge stage into master' && git push origin HEAD:master HEAD:stage && git tag $1 && git push origin $1
}
