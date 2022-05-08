#!/bin/bash

#./reports/healthcheck.json
FILE=$1 

HIGHRISKITEMS=$(          cat $FILE | jq -r ' .highriskitems[]'          | wc -l | xargs > /tmp/res.txt && cat /tmp/res.txt)
MEDIUMRISKITEMS=$(        cat $FILE | jq -r ' .mediumriskitems[]'        | wc -l | xargs > /tmp/res.txt && cat /tmp/res.txt)
LOWRISKITEMS=$(           cat $FILE | jq -r ' .lowriskitems[]'           | wc -l | xargs > /tmp/res.txt && cat /tmp/res.txt)
INFORMATIONALRISKITEMS=$( cat $FILE | jq -r ' .informationalriskitems[]' | wc -l | xargs > /tmp/res.txt && cat /tmp/res.txt)
DT=$( date "+%a %d %b %Y, %H:%M %Z" )

if [ $HIGHRISKITEMS == 'null' ] || [ $MEDIUMRISKITEMS == 'null' ] || [ $LOWRISKITEMS == 'null' ] || [ $INFORMATIONALRISKITEMS == 'null' ]
then
  echo "ERROR ($DT)"
  exit 1
else
  echo "H:${HIGHRISKITEMS} M:${MEDIUMRISKITEMS} L:${LOWRISKITEMS} i:${INFORMATIONALRISKITEMS} ($DT)"
fi
