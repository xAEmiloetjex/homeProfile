#!/usr/bin/env bash
# DEFAULT CONFIG PLEASE DON'T CHANGE
# IT IS USED AS A REFRENCE FOR NEW PROFILES
source "$HOME/homeProfile/globals.sh"

export P_NAME=$HPPROF
export P_PATH="$HPPROFILES/$P_NAME"

echo "$HPPREF Loaded profile: $P_NAME"
echo "$HPPREF Target home dir: $HPHOME"

export P_MAP=(
  # (RelativeTargetPath 
  #   AbsoluteSourcePath)
  ".config:$HPHOME/.config"
  # ".local:$HPHOME/.local"
  ".zshrc:$HPHOME/.zshrc"
  ".zsh_history:$HPHOME/.zsh_history"
  ".bashrc:$HPHOME/.bashrc"
  ".bash_history:$HPHOME/.bash_history"
  ".bash_profile:$HPHOME/.bash_profile"
  ".p10k.zsh:$HPHOME/.p10k.zsh"
  ".profile:$HPHOME/.profile"
)