#!/bin/bash

set -x

#./reports/healthcheck.json
FILE=$1 

HIGHRISKITEMS=$(          cat $FILE | jq -r ' .highriskitems[]'          | wc -l | xargs)
MEDIUMRISKITEMS=$(        cat $FILE | jq -r ' .mediumriskitems[]'        | wc -l | xargs)
LOWISKITEMS=$(            cat $FILE | jq -r ' .lowriskitems[]'           | wc -l | xargs)
INFORMATIONALRISKITEMS=$( cat $FILE | jq -r ' .informationalriskitems[]' | wc -l | xargs)
DT=$( date )

if [ $HIGHRISKITEMS == 'null' ] || [ $MEDIUMRISKITEMS == 'null' ] || [ $LOWISKITEMS == 'null' ] || [ $INFORMATIONALRISKITEMS == 'null' ]
then
  echo "ERROR ($DT)"
  exit 1
else
  echo "H:${HIGHRISKITEMS} M:${MEDIUMRISKITEMS} L:${LOWISKITEMS} i:${INFORMATIONALRISKITEMS} ($DT)"
fi
