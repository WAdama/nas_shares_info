#!/bin/bash
# Version 1.0
#Be sure you have valid SSH credentials in your device

CONF=$1
TOTAL=0
source $CONF
echo "<prtg><?xml version=\"10.0\" encoding=\"UTF-8\" ?>"
for SHARE in "${SHARES[@]}"
do
REC="/$VOLUME/$SHARE/""#recycle/"
IFS=" " read USED VOLNAME <<< `du -s /$VOLUME/$SHARE/`
TOTAL=$((TOTAL + USED))
echo "<result><channel>Volume $SHARE: In Use</channel><value>`echo | gawk -v PRE=${USED} 'BEGIN {OFMT="%.2f";print PRE / 1048576}'`</value><unit>Custom</unit><CustomUnit>GByte</CustomUnit><float>1</float></result>"
if [ -d $REC ]
  then
	IFS=" " read RECY RECNAME <<< `du -s $REC`
	echo "<result><channel>Volume $SHARE: Recyclable</channel><value>`echo | gawk -v PRE=${RECY} 'BEGIN {OFMT="%.2f";print PRE / 1048576}'`</value><unit>Custom</unit><CustomUnit>GByte</CustomUnit><float>1</float></result>"
fi
done
echo "<result><channel>Total</channel><value>`echo | gawk -v PRE=${TOTAL} 'BEGIN {OFMT="%.2f";print PRE / 1048576}'`</value><unit>Custom</unit><CustomUnit>GByte</CustomUnit><float>1</float></result></prtg>"
exit
