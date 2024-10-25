#!/bin/bash
#Version 1.0.6
declare -a SHARES
TOTAL=0
while IFS="|" read -r key value; do
    declare -a "$key=$value"
done < <(jq -r '. | to_entries | .[] | .key + "|" + "(" + (.value | @sh) + ")"' "$1")
echo "<prtg><?xml version=\"10.0\" encoding=\"UTF-8\" ?>"
for SHARE in "${SHARES[@]}"
do
REC="/${VOLUME[0]}/$SHARE/#recycle/"
IFS=" " read -r "USED[0]" "USED[1]" "USED[2]" "USED[3]" <<< "$(btrfs filesystem du -s --raw /"${VOLUME[0]}"/"$SHARE"/ | tail -1)"
TOTAL=$((TOTAL + USED[0]))
echo "<result><channel>Share $SHARE: In Use</channel><value>${USED[0]}</value><unit>BytesDisk</unit><float>0</float></result>"
if [ -d "$REC" ]
  then
    IFS=" " read -r "RECY[0]" "RECY[1]" "RECY[2]" "RECY[3]" <<< "$(btrfs filesystem du -s --raw "$REC" | tail -1)"
    echo "<result><channel>Share $SHARE: Recyclable</channel><value>${RECY[0]}</value><unit>BytesDisk</unit><float>0</float></result>"
fi
done

echo "<result><channel>Total</channel><value>$TOTAL</value><unit>BytesDisk</unit><float>0</float></result></prtg>"
exit
