#!/bin/bash
# Version 1.0.6
declare -a SHARES
TOTAL=0
while IFS="|" read -r key value; do
    declare -a "$key=$value"
done < <(jq -r '. | to_entries | .[] | .key + "|" + "(" + (.value | @sh) + ")"' "$1")
echo "<prtg><?xml version=\"10.0\" encoding=\"UTF-8\" ?>"
for SHARE in "${SHARES[@]}"
do
REC="/${VOLUME[0]}/$SHARE/#recycle/"
IFS=$'\t' read -r "USED[0]" "USED[1]" <<< "$(du -s -b /"${VOLUME[0]}"/"$SHARE"/)"
TOTAL=$((TOTAL + USED[0]))
echo "<result><channel>Share $SHARE: In Use</channel><value>${USED[0]}</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>"
if [ -d "$REC" ]
  then
	IFS=$'\t' read -r "RECY[0]" "RECY[1]" <<< "$(du -s -b "$REC")"
	echo "<result><channel>Share $SHARE: Recyclable</channel><value>${RECY[0]}</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>"
fi
done
echo "<result><channel>Total</channel><value>$TOTAL</value><unit>BytesDisk</unit><float>0</float></result></prtg>"
exit