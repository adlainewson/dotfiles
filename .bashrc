#
# ~/.bashrc
#

[[ $- != *i* ]] && return

#PS1="[\[$(tput bold)\]\u\[$(tput sgr0)\]@\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;129m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]](\w)\$ \[$(tput sgr0)\]"
PS1="[\[$(tput bold)\]\u\[$(tput sgr0)\]@\[$(tput bold)\]\[$(tput setaf 5)\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \w]\$ \[$(tput sgr0)\]"
#PS1='[\u @ \h \W]$ '

# Show if this is Ranger shell
if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi

export TERM=xterm-256color
export BROWSER=/usr/bin/google-chrome-stable
export STEAM_FRAME_FORCE_CLOSE=1
export BC_ENV_ARGS=/home/adlai/.bc



[[ -f ~/.extend.bashrc ]] && . ~/.extend.bashrc

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# Path
PATH=$PATH:/home/adlai/bin:/home/adlai/usr/local/bin:/home/adlai/usr/bin:/home/adlai/usr/games/bin
export PATH

# Aliases
source $HOME/.aliases

# Input mode
set -o vi


# Nice little function to wrap xclip
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}

export MARKPATH=$HOME/.marks
function jump {
  cd -P $MARKPATH/${1-0} 2> /dev/null || echo "No such mark: $1"
}
function mark {
  mkdir -p $MARKPATH; rm $MARKPATH/${1-0}; ln -s $(pwd) $MARKPATH/${1-0}
}
function marks {
  ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- && echo
}

# Colored man pages/less output
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}
