#!/usr/bin/env bash
# DEFAULT CONFIG PLEASE DON'T CHANGE
# IT IS USED AS A REFRENCE FOR NEW PROFILES
source "$HOME/homeProfile/globals.sh"

export P_NAME=$HPPROF
export P_PATH="$HPPROFILES/$P_NAME"

echo "$HPPREF Loaded profile: $P_NAME"
echo "$HPPREF Target home dir: $HPHOME"

# "StoragePath:SourcePath"
export P_MAP=()

export P_DIFF_DIRS=()