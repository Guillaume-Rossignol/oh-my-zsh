alias lc="wc -l"
alias pstorm="nohup phpstorm &"
alias swagger-editor="docker pull swaggerapi/swagger-editor && docker run -d -p 8080:8080 swaggerapi/swagger-editor"
alias composer='docker run --rm --interactive --tty \
  --volume $PWD:/app \
  --volume ${COMPOSER_HOME:-$HOME/.composer}:/tmp \
  composer '
alias mdds="make docker-dev-shell"
alias gitListAssumeUnchangedFiles="git ls-files -v|grep '^h'"
alias gitRevertAssumeUnchanged="git update-index --no-assume-unchanged "
cleanDB() {
	docker-compose exec mysql /bin/bash -c 'mysql -uroot -p${MYSQL_ROOT_PASSWORD} '$1' -e "DROP DATABASE '$1'; CREATE DATABASE '$1';"'
}
importDB(){
	zcat $1 | docker-compose exec -T mysql sh -c 'exec mysql -uroot -p${MYSQL_ROOT_PASSWORD} '$2
}
alias gitAssumeUnchanged="git update-index --assume-unchanged "
taptempo() {
	perl -ne 'BEGIN{use Time::HiRes qw/gettimeofday/} push(@t,0+gettimeofday()); shift(@t) if @t>5; printf("%3.0f bpm",60*(@t-1)/($t[-1]-$t[0])) if @t>1'
}
alias listeBackupWiza="aws s3 ls s3://wizaplace-tools-database-exports/ --recursive --human-readable"
importAnonymeBDD() {
    aws s3 cp s3://wizaplace-tools-database-exports/$1 ${1%/*}.sql.gz

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
fixup() {
	git commit --fixup HEAD~$1 &&\
	squash $(($1+2))
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

gcb_from_dev () {
    git fetch origin && git checkout -B $1 origin/develop
}

meteo() {
	curl wttr.in/${1:-"Lyon"};
}
met() {
	curl "wttr.in/${1:-"Lyon"}?format=2";
}
