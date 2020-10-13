#!/bin/bash

#./reports/healthcheck.json

FILE=$1 

HIGHRISKITEMS=$(          cat $FILE | jq -r ' .highriskitems[]'          | wc -l | xargs)
MEDIUMRISKITEMS=$(        cat $FILE | jq -r ' .mediumriskitems[]'        | wc -l | xargs)
LOWISKITEMS=$(            cat $FILE | jq -r ' .lowriskitems[]'           | wc -l | xargs)
INFORMATIONALRISKITEMS=$( cat $FILE | jq -r ' .informationalriskitems[]' | wc -l | xargs)
DT=$( date )

echo "H:${HIGHRISKITEMS} M:${MEDIUMRISKITEMS} L:${LOWISKITEMS} i:${INFORMATIONALRISKITEMS} ($DT)"
