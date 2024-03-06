LFCD="$HOME/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
 source "$LFCD"
fi

bindkey -s '^o' 'lfcd\n'  # zsh

source $HOME/.config/lf/lf.bash
