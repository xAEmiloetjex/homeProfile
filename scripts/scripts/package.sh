#!/usr/bin/env bash
source "$HOME/homeProfile/globals.sh"

PKGDIR=$HPROOT/pkg

mv -f $PKGDIR/.git $HPROOT/.git
rm -rf $PKGDIR

mkdir -p $PKGDIR/profiles/default $PKGDIR/scripts
mv -f $HPROOT/.git $PKGDIR/.git


cp -r $HPDEFAULTPROF/config.sh $PKGDIR/profiles/default/config.sh
cp -r $HPROOT/scripts $PKGDIR/scripts
cp $HPROOT/globals.sh $PKGDIR/globals.sh
cp $HPROOT/homeProfile.sh $PKGDIR/homeProfile.sh
cp $HPROOT/README.md $PKGDIR/README.md
cp $HPROOT/LICENSE $PKGDIR/LICENSE

