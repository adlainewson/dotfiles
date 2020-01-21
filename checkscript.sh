#!/bin/bash

function ask {
   echo "Difference found when checking $1 files: would you like to see?"
   echo "Y/n:"
   read ANS
   if [ "$ANS" == "y" ] || [ "$ANS" == "yes" ] || [ "$ANS" == "Y" ]; then
      vimdiff $2 $3
   else
      echo "OK, skipping"
   fi
}

declare -A dfiles
dfiles[i3]="i3/config $HOME/.config/i3/config"
dfiles[i3]=".zshrc $HOME/.zshrc"
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

echo "Checking for file differences..."

for i in "${!dfiles[@]}"; do
   DIFF=$( diff ${dfiles[$i]} )
   if [ "$DIFF" != "" ]; then
      ask $i ${dfiles[$i]}
   fi
done

echo "All done!"
