#!/bin/bash
# Version 1.0.2
#Be sure you have valid SSH credentials in your device

CONF=$1
TOTAL=0
source $CONF
echo "<prtg><?xml version=\"10.0\" encoding=\"UTF-8\" ?>"
for SHARE in "${SHARES[@]}"
do
REC="/$VOLUME/$SHARE/""#recycle/"
SNAP="/$VOLUME/@sharesnap/$SHARE"
IFS=" " read USED VOLNAME <<< `du -s -b /$VOLUME/$SHARE/`
TOTAL=$((TOTAL + USED))
echo "<result><channel>Volume $SHARE: In Use</channel><value>$USED</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>"
if [ -d $REC ]
  then
	IFS=" " read RECY RECNAME <<< `du -s -b $REC`
	echo "<result><channel>Volume $SHARE: Recyclable</channel><value>$RECY</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>"
fi
done
echo "<result><channel>Total</channel><value>$((TOTAL*1024))</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result></prtg>"
exit
