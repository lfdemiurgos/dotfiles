# Created by newuser for 5.9
export ZSH_CONFIG=~/.config/shell

set -a
source $ZSH_CONFIG/env.txt
source $ZSH_CONFIG/secrets.txt
set +a

source $ZSH_CONFIG/profile.zsh
source $ZSH_CONFIG/plugins.zsh


if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi
eval "$(starship init zsh)"
