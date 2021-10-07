#!/bin/bash

function ask {
   echo "difference found when checking config for $1: "
   echo "> [diff/accept/skip]?"
   read ANS
   if [ $( echo $ANS | grep -E '^[Dd]' ) ]; then
      vimdiff $2 $3 2>/dev/null
   elif [ $( echo $ANS | grep -E '^[Aa]' ) ]; then
      cp $3 ./$2
      echo ">copied $3 > $2"
   elif [ $( echo $ANS | grep -E '^[Ss]' ) ]; then
      echo ">skipping"
   fi
}

declare -A dfiles
dfiles[i3]="i3/config $HOME/.config/i3/config"
dfiles[polybar]="polybar/config $HOME/.config/polybar/config"
dfiles[ranger_rc]="ranger/rc.conf $HOME/.config/ranger/rc.conf"
dfiles[ranger_rifle]="ranger/rifle.conf $HOME/.config/ranger/rifle.conf"
dfiles[bash]=".bashrc $HOME/.bashrc"
dfiles[zsh]=".zshrc $HOME/.zshrc"
dfiles[aliases]=".aliases $HOME/.aliases"
dfiles[tmux]=".tmux.conf $HOME/.tmux.conf"
dfiles[vim]=".vimrc  $HOME/.vimrc"
dfiles[Xresources]=".Xresources $HOME/.Xresources"
dfiles[termite]="termite/config $HOME/.config/termite/config"
dfiles[rofi]="rofi/config.rasi $HOME/.config/rofi/config.rasi"

echo "checking for file differences..."

for i in "${!dfiles[@]}"; do
   DIFF=$( diff ${dfiles[$i]} )
   if [ "$DIFF" != "" ]; then
      ask $i ${dfiles[$i]}
   fi
done

echo "done"
