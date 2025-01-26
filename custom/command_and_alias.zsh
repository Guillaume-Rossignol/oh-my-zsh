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
squash () {
    GIT_SEQUENCE_EDITOR=true bash -c "git rebase -i --autosquash HEAD~$1"
}
fixup() {
	git commit --fixup HEAD~$1 &&\
	squash $(($1+2))
}
git_clean () {
    git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d
}
gcb_from_master () {
    git fetch origin && git checkout -B $1 origin/master
}
git_auto_fixup() {
	SHA =$git rev-parse $1 \
		&& git commit --fixup $SHA  \
		&& git rebase -i --autosquash $SHA~ 
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
