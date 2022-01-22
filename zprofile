#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export LIBSEAT_BACKEND=logind

# Enable firefox to use wayland
export MOZ_ENABLE_WAYLAND=1

# If qt apps are using Xorg
export QT_QPA_PLATFORM=wayland-egl

# Fullscreen zathura
alias zathura="zathura --mode fullscreen"

# Set dark theme for whatever applications
export GTK_THEME=Arc-Darker

# pyenv setup
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"

# if running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
 exec dbus-run-session sway  
fi
