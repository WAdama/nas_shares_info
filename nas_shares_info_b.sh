#!/bin/bash

CONF=$1
TOTAL=0
source $CONF
echo "<prtg><?xml version=\"10.0\" encoding=\"UTF-8\" ?>"
for SHARE in "${SHARES[@]}"
do
REC="/$VOLUME/$SHARE/""#recycle/"
IFS=" " read USED EXCLUSIVE SHARED VOLNAME <<< `btrfs filesystem du -s --raw /$VOLUME/$SHARE/ | tail -1`
TOTAL=$((TOTAL + USED))
echo "<result><channel>Volume $SHARE: In Use</channel><value>$USED</value><unit>BytesDisk</unit><float>0</float></result>"
if [ -d $REC ]
  then
	IFS=" " read RECY EXCLUSIVE SHARED RECNAME <<< `btrfs filesystem du -s --raw $REC | tail -1`
	echo "<result><channel>Volume $SHARE: Recyclable</channel><value>$RECY</value><unit>BytesDisk</unit><float>0</float></result>"
fi
done

echo "<result><channel>Total</channel><value>$TOTAL</value><unit>BytesDisk</unit><float>0</float></result></prtg>"
exit
