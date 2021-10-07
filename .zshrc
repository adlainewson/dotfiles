# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/adlai/.oh-my-zsh"
export TERM=xterm-256color
#export BROWSER=/usr/local/bin/chrome
export STEAM_FRAME_FORCE_CLOSE=1
export BC_ENV_ARGS=/home/adlai/.bc
## The nice sea-green used by i3 is #237d6e
export LS_COLORS="$LS_COLORS:ow=1;34;43:"
export EDITOR=vim
export GITPAT=361f20b60e442fcb26e90a32428bacf428182eba

# Stuff for git
git config --global alias.s status

MYBIN=/home/adlai/bin
MYLOCALBIN=/home/adlai/usr/local/bin
PATH=$PATH:$MYBIN/applications:$MYBIN/display:$MYBIN/misc:$MYBIN/utilities:$MYBIN/webapps:$MYLOCALBIN:/home/adlai/usr/games/bin
export PATH

# autocomplete aliases
setopt COMPLETE_ALIASES


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Colored man pages/less output
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal



# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Vi mode
bindkey -v
# Search history, re-bind required when in vi mode
#bindkey "^R"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

source $HOME/.aliases

# Shell functions 


timer() {
   # Count down script that accepts same arguments as sleep (eg, 5s, 3m, 4h)
   #   requires integer arguments. 
   T=0
   T_MAX=$( echo $1 | grep -Eo '^[0-9^.]+' )
   T_TYPE=$( echo $1 | grep -o '[smhd]$' )
   echo "Counting down $T_MAX$T_TYPE"
   # Convert h to m
   if [ "$T_TYPE" = "h" ]; then
      T_TYPE="m"
      T_MAX=$(( 60*$T_MAX ))
   fi
   while [ $T -le $T_MAX ]; do
      echo -n $(( $T_MAX- $T ))$T_TYPE... 
      T=$(( $T + 1 ))
      sleep 1$T_TYPE;
   done 
   echo "\n Timer done."
}

fuck() {
   sudo $(history -1 | sed -E 's/^[[:space:]]*[0-9]+\*?[[:space:]]*//') 
}

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




#zstyle ':completion:*' menu select
zmodload zsh/complist

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# The following lines were added by compinstall

#zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' menu select=0 search
#zstyle ':completion:*' menu select=0 interactive
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle :compinstall filename '/home/adlai/.zshrc'

# Do not autoselect the first completion entry
#unsetopt MENU_COMPLETE
#setopt NO_AUTOLIST BASH_AUTOLIST NO_MENUCOMPLETE
# All three prevent auto-filling the prompt with suggestions from hitting the tab key
setopt NO_AUTO_MENU
setopt NO_MENU_COMPLETE 
setopt BASH_AUTO_LIST

# SUDO prompt colours
export SUDO_PROMPT=$'\e[31m[sudo]\e[0m \e[1mpassword for %p:\e[0m '

autoload -Uz compinit
compinit
# End of lines added by compinstall


# Fish-like syntax highlighting. Has to be at the end.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
