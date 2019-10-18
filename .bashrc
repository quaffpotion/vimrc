export EDITOR="code --wait"

#Ruby items from AppAcademy
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

fn bashrc() {
	vim ~/.bashrc
}
fn sobashrc() {
	source ~/.bashrc
}
fn zshrc() {
    vim ~/.zshrc
}
fn vimrc() {
    vim ~/.vimrc
}

INITIALPATH=$PATH
INITIALPS1=\$\{ret_status\}\ %\{\$fg\[cyan\]%\}%c%\{\$reset_color%\}\ \$\(git_prompt_info\)
fn udock() {
    disable exec
    alias export=/Users/anthonymartino/hoborg-scripts/docker-scripts/export 
    alias history=/Users/anthonymartino/hoborg-scripts/docker-scripts/history
    disable kill 
    disable logout 
    disable wait
    PATH=/Users/anthonymartino/hoborg-scripts/docker-scripts:$INITIALPATH
    PS1=${fg[blue]}DOCKER\ ${fg[cyan]}🐳${reset_color}${fg[blue]}\ \ %c${reset_color}\ 
}
fn ddock() {
    enable exec
    unalias export
    alias history=omz_history
    enable kill
    enable logout
    enable wait
    PATH=$INITIALPATH
    PS1=$INITIALPS1
}
fn ung() {
    disable test
    PATH=/Users/anthonymartino/hoborg-scripts/ng-scripts:$INITIALPATH
    PS1=${fg_bold[green]}A${reset_color}${fg[green]}ng${reset_color}${fg_bold[green]}ular${reset_colors}${fg[grey]}\ %c${reset_color}\ 
}
fn dng() {
    enable test
    PATH=$INITIALPATH
    PS1=$INITIALPS1
}

sf=$(tput setaf 0)
sb=$(tput setab 4)
sc=$sf$sb
sdc=$(tput sgr0)

fn prettyprint() {
	echo  $sc$1$sdc
}
alias pp=prettyprint
alias gl="git log --oneline"

fn ggc() {
	if [ $# = 0 ] ; then
		echo "$(tput setab 1)$(tput setaf 7)\nNo commit message received" 
		return 1
	fi
	pp "\nAdding files..."
	git add -A
	pp "\nChecking after..."
	git status
	if git status | grep -q "nothing" ; then
		echo "$(tput setab 1)$(tput setaf 7)\nNothing new to commit$(tput sgr0)"
		return 1
	fi

	pp "\nCommitting with message \"$1\"..."
	git commit -m $1
	if [ $? = 0 ] ; then
		echo "$(tput setab 2)$(tput setaf 0)\nSuccessfully committed changes$sdc"
		pp "\nPushing commit..."
		if git push ; then
			echo "$(tput setab 2)$(tput setaf 0)\nSuccessfully pushed changes$sdc"
			return 0
		else
			echo "$(tput setab 1)$(tput setaf 7)\nFailed to push changes$sdc" 
			return 1
		fi
	else
	    echo "$(tput setab 1)$(tput setaf 7)\nFailed to commit changes$sdc"
	    return 1
	fi
}
alias gpo="git push origin"
alias gs="git status"
alias gd="git diff"

fn testing() {
	prettyprint "Checking $1"

}

fn work() {
    cd /Users/anthonymartino/Dropbox/maths/geometricgrouptheory/ggt
	open /Users/anthonymartino/Dropbox/maths/geometricgrouptheory/ggt/ggt.pdf -a /Applications/Skim.app
	vim -S /Users/anthonymartino/Dropbox/maths/geometricgrouptheory/ggt/session.vim 
}

fn putdown() {
    echo "Stopping all containers..."
    docker stop $(docker ps -a -q) 
    echo "Removing all containers..."
    docker rm $(docker ps -a -q)
}
