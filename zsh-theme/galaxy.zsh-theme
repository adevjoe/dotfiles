#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Galaxy Terminal Theme
#
# Author: adevjoe
# https://github.com/adevjoe/shell-tool/zsh-theme/galaxy.zsh-theme
#
# ------------------------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{10}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%f%F{11}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

get_welcome_symbol() {

	echo -n "%(?..%F{1})"
	
	local welcome_symbol='$'
	[ $EUID -ne 0 ] || welcome_symbol='#'
	
	echo -n $welcome_symbol
	echo -n "%(?..%f)"
}

# local get_time="%F{grey}[%*]%f"

get_current_branch() {

	local branch=$(git_current_branch)
	
	if [ -n "$branch" ]; then
		echo -n $ZSH_THEME_GIT_PROMPT_PREFIX
		echo -n $(parse_git_dirty)
		echo -n "‹${branch}›"
		echo -n $ZSH_THEME_GIT_PROMPT_SUFFIX
	fi
}

get_prompt() {

	# 256-colors check (will be used later): tput colors
	
	echo -n "%F{6}%n%f" # User
	echo -n "%F{8}@%f" # at
	echo -n "%F{12}%m%f" # Host
	echo -n "%F{8}:%f" # in 
	echo -n "%{$reset_color%}%~" # Dir
	echo -n "$(get_current_branch)" # Git branch
	echo -n "\n"
	echo -n "$(get_welcome_symbol)%{$reset_color%} " # $ or #
}

export GREP_COLOR='1;31'

PROMPT='$(get_prompt)'

