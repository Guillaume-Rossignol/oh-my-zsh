alias lc="wc -l"
alias keepass="nohup mono ~/opt/KeePass-2.40/KeePass.exe&"
alias pstorm="nohup phpstorm &"
taptempo() {
	perl -ne 'BEGIN{use Time::HiRes qw/gettimeofday/} push(@t,0+gettimeofday()); shift(@t) if @t>5; printf("%3.0f bpm",60*(@t-1)/($t[-1]-$t[0])) if @t>1'
}
push_bref () {
    : ${1=latest}
    images=('fpm-dev-gateway' 'php-72' 'php-73' 'php-72-fpm' 'php-73-fpm' 'php-72-fpm-dev' 'php-73-fpm-dev')
    cd ~/Projets/bref/runtime
    make build TAG=$1
    for i ($images) docker push bref/$i
}
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

