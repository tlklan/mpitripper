#!/bin/bash

WORKINGDIR=`pwd`
OUTPUTDIR=/srv/werket.tlk.fi/mpit

echo "Target directory is $OUTPUTDIR"
echo "Removing current mirrored copy ..."
rm -r $OUTPUTDIR

echo "Logging in and getting PHPSESSID ..."
PHPSESSID=`./get_phpsessid`
echo "Got PHPSESSID: $PHPSESSID"

echo "Ripping site ..."
mkdir $OUTPUTDIR
cd $OUTPUTDIR
mkdir "jm"

# Create the logout "file" so we don't accidentally crawl and unlogin ourselves
touch "jm/index.php?cmd=logout&"

#
# Edit 2013-05-27: -k switch was removed since it doesn't work together with -nc,
# and it's not needed anymore with wget 1.13
#
# Edit 2018-08-28: domain changed
#
wget -nH -nc -nv -r -np --cookies=off --reject '*logout*' --header="Cookie: PHPSESSID=$PHPSESSID" https://mp-it.fi/jm/shop.php

echo "Applying various workarounds"

# copy our custom products.php to the target directory
cd $WORKINGDIR
cp products.php $OUTPUTDIR/jm
chmod 644 $OUTPUTDIR/jm/products.php

# prepend the user authentication code to shop.php
cat userauth.php $OUTPUTDIR/jm/shop.php > /tmp/out && mv /tmp/out $OUTPUTDIR/jm/shop.php

# print todays date to a file
date > $OUTPUTDIR/jm/updated.txt

exit 0
