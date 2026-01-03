#!/usr/bin/env bash
source "$HOME/homeProfile/globals.sh"

export HPHOME=$HOME
export HPPROF="default"
export HPBACK=0
export HPBACK1=0
export HPBACK2=0
export HPDIFF=0

function run_save {
  echo "$HPPREF started procedure: run_save"
  PPATH="$HPPROFILES/$HPPROF"
  source "$PPATH/config.sh"

  FSTORE=$PPATH/storage/files/_
  DSTORE=$PPATH/storage/diffs/_

  mkdir -p $FSTORE $DSTORE

  for _path in "${P_MAP[@]}"
  do
    TPATH="$FSTORE/${_path%%:*}"
    SPATH="${_path#*:}"

    cp -rv $SPATH $TPATH
  done
}

function run_load {
  echo "$HPPREF started procedure: run_load"
  PPATH="$HPPROFILES/$HPPROF"
  source "$PPATH/config.sh"

  FSTORE=$PPATH/storage/files/_

  for _path in "${P_MAP[@]}"
  do
    TPATH="$FSTORE/${_path%%:*}"
    SPATH="${_path#*:}"

    rm -rfv $SPATH
    cp -rv $TPATH $SPATH
  done
}

function run_save_backup {
  echo "$HPPREF started procedure: run_save_backup"
  PPATH="$HPPROFILES/$HPPROF"
  FSTORE=$PPATH/storage/files
  source "$PPATH/config.sh"
  BUID="backup_$HPBACK"
  BUPATH="$FSTORE/$BUID"

  mkdir -p $BUPATH
  cp -rv $FSTORE/_/* $BUPATH
}

function run_load_backup {
  echo "$HPPREF started procedure: run_save_backup"
  PPATH="$HPPROFILES/$HPPROF"
  FSTORE=$PPATH/storage/files
  source "$PPATH/config.sh"
  BUID="backup_$HPBACK"
  BUPATH="$FSTORE/$BUID"

  rm -rfv $FSTORE/_
  cp -rv $BUPATH/_ $FSTORE/_
}

function run_diff_backups {
  echo "$HPPREF started procedure: run_diff_backups"

  PPATH="$HPPROFILES/$HPPROF"

  source "$PPATH/config.sh"

  FSTORE=$PPATH/storage/files/
  DSTORE=$PPATH/storage/diffs/$BUID

  DIFFID="diff_$HPDIFF"
  DIFFPATH="$DSTORE/$DIFFID"

  BUID1="backup_$HPBACK1"
  BU1PATH="$FSTORE/$BUID1"
  BUID2="backup_$HPBACK2"
  BU2PATH="$FSTORE/$BUID2"

  for _dir in "${P_DIFF_DIRS[@]}"
  do
    mkdir -p $DIFFPATH/$_dir
  done

  for _path in "${P_MAP[@]}"
  do
    T1PATH="$BU1PATH/${_path%%:*}"
    T2PATH="$BU2PATH/${_path%%:*}"
    DPATH="$DIFFPATH/${_path%%:*}"
    diff -c "$T1PATH" "$T2PATH" >> "$DPATH.diff-on"
    diff -c "$T2PATH" "$T1PATH" >> "$DPATH.diff-off"
  done
}

function run_diff_backup {
  echo "$HPPREF started procedure: run_diff_backup"

  PPATH="$HPPROFILES/$HPPROF"

  source "$PPATH/config.sh"

  FSTORE=$PPATH/storage/files/
  DSTORE=$PPATH/storage/diffs/$BUID

  DIFFID="diff_$HPDIFF"
  DIFFPATH="$DSTORE/$DIFFID"

  BUID1="backup_$HPBACK1"
  BU1PATH="$FSTORE/$BUID1"
  BUID2="backup_$HPBACK2"
  BU2PATH="$FSTORE/_"

  for _dir in "${P_DIFF_DIRS[@]}"
  do
    mkdir -p $DIFFPATH/$_dir
  done

  for _path in "${P_MAP[@]}"
  do
    T1PATH="$BU1PATH/${_path%%:*}"
    T2PATH="$BU2PATH/${_path%%:*}"
    DPATH="$DIFFPATH/${_path%%:*}"

    diff -c "$T1PATH" "$T2PATH" >> "$DPATH.diff-on"
    diff -c "$T2PATH" "$T1PATH" >> "$DPATH.diff-off"
  done

}

function run_edit {
  echo "$HPPREF started procedure: run_save"
  PPATH="$HPPROFILES/$HPPROF"
  source "$PPATH/config.sh"

  if [ -z "$EDITOR" ]
  then
    export EDITOR="nano"
  fi

  $EDITOR "$PPATH/config.sh"
}

function run_apply_diff {
  echo "TODO: run_apply_diff isn't implemented yet"
  PPATH="$HPPROFILES/$HPPROF"

  source "$PPATH/config.sh"

  FSTORE=$PPATH/storage/files/
  DSTORE=$PPATH/storage/diffs/$BUID
}

function run_unapply_diff {
  echo "TODO: run_unapply_diff isn't implemented yet"
}

case $1 in
  "help")
    cat "$HPROOT/README.md"
    ;;
  "new")
    mkdir -p "$HPPROFILES/$2"
    cp "$HPDEFAULTPROF/config.sh" "$HPPROFILES/$2/config.sh"
    ;;
  "edit")
    HPPROF=$2
    run_edit
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
  "diff_backup")
    HPPROF=$2
    HPBACK1=$3
    HPDIFF=$4
    run_diff_backup
    ;;
  "diff_backups")
    HPPROF=$2
    HPBACK1=$3
    HPBACK2=$4
    HPDIFF=$5
    run_diff_backups
    ;;
  "apply_diff")
    HPPROF=$2
    HPDIFF=$3
    run_apply_diff
    ;;
  "unapply_diff")
    HPPROF=$2
    HPDIFF=$3
    run_unapply_diff
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
  *)
    cat "$HPROOT/README.md"
    ;;
esac