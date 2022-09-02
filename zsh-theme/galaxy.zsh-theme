#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Galaxy Terminal Theme
#
# Author: adevjoe
# https://github.com/adevjoe/dotfiles/zsh-theme/galaxy.zsh-theme
#
# ------------------------------------------------------------------------------

get_color() {
	echo -n "\e[38;05;${1}m"
}

ZSH_THEME_GIT_PROMPT_PREFIX=" $(get_color 10)"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="$(get_color 11)"
ZSH_THEME_GIT_PROMPT_CLEAN=""

get_welcome_symbol() {

	echo -n "%(?:%{$(get_color 7)%}:%{$(get_color 1)%})"
	
	local welcome_symbol='$'
	[ $EUID -ne 0 ] || welcome_symbol='#'
	
	echo -n $welcome_symbol
	echo -n "%(?..%f)"
}

get_current_branch() {

	local branch=$(git_current_branch)
	
	if [ -n "$branch" ]; then
		echo -n $ZSH_THEME_GIT_PROMPT_PREFIX
		echo -n $(parse_git_dirty)
		echo -n "‹${branch}›"
		echo -n $ZSH_THEME_GIT_PROMPT_SUFFIX
	fi
}

get_icon() {
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        	echo -n " 🐧 "
	elif [[ "$OSTYPE" == "darwin"* ]]; then
        	echo -n "  "
	else
        	echo -n " 🖥 "
	fi
}

get_prompt() {

	# 256-colors check (will be used later): tput colors
	
        echo -n "$(get_icon)" # icon
	echo -n "$(get_color 6)%n" # User
	echo -n "$(get_color 8)@" # at
	echo -n "$(get_color 12)%m" # Host
	echo -n "$(get_color 8):" # in 
	echo -n "%{$reset_color%}%~" # Dir
	echo -n "$(get_current_branch)" # Git branch
	echo -n "\n"
	echo -n "$(get_welcome_symbol)%{$reset_color%} " # $ or #
}

PROMPT='$(get_prompt)'

