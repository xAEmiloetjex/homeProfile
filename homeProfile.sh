#!/usr/bin/env bash
source "$HOME/homeProfile/globals.sh"

export HPHOME=$HOME
export HPPROF="default"
export HPBACK=0

function run_save {
  echo "$HPPREF started procedure: run_save"
  PPATH="$HPPROFILES/$HPPROF"
  source "$PPATH/config.sh"

  mkdir -p $PPATH/storage/_

  for _path in "${P_MAP[@]}"
  do
    TPATH="$PPATH/storage/_/${_path%%:*}"
    SPATH="${_path#*:}"
    # echo "$TPATH = $SPATH"
    cp -rv $SPATH $TPATH
  done
}

function run_load {
  echo "$HPPREF started procedure: run_load"
  PPATH="$HPPROFILES/$HPPROF"
  source "$PPATH/config.sh"

  mkdir -p $HPHOME

  for _path in "${P_MAP[@]}"
  do
    TPATH="$PPATH/storage/_/${_path%%:*}"
    SPATH="${_path#*:}"
    # echo "$TPATH = $SPATH"
    rm -rfv $SPATH
    cp -rv $TPATH $SPATH
  done
}

function run_save_backup {
  echo "$HPPREF started procedure: run_save_backup"
  PPATH="$HPPROFILES/$HPPROF"
  source "$PPATH/config.sh"
  BUID="backup_$HPBACK"
  BUPATH="$PPATH/storage/$BUID"

  cp -rv $PPATH/storage/_ $BUPATH
}

function run_load_backup {
  echo "$HPPREF started procedure: run_save_backup"
  PPATH="$HPPROFILES/$HPPROF"
  source "$PPATH/config.sh"
  BUID="backup_$HPBACK"
  BUPATH="$PPATH/storage/$BUID"

  rm -rfv $PPATH/storage/_   
  cp -rv $BUPATH $PPATH/storage/_
}

case $1 in
  "new")
    mkdir -p "$HPPROFILES/$2"
    cp "$HPDEFAULTPROF/config.sh" "$HPPROFILES/$2/config.sh"
    ;;
  "save_backup")
    HPPROF=$2
    HPBACK=$3
    run_save_backup
    ;;
  "load_backup")
    HPPROF=$2
    HPBACK=$3
    run_load_backup
    ;;
  "save")
    HPPROF=$2
    run_save
    ;;
  "load")
    HPPROF=$2
    run_load
    ;;
  "save_from")
    HPPROF=$2
    HPHOME=$3
    run_save
    ;;
  "load_to")
    HPPROF=$2
    HPHOME=$3
    run_load
    ;;
esac