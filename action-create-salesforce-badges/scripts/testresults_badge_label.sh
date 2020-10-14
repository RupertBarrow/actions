#!/bin/bash

FILE=$1

PASSING=$( cat $FILE | jq .result.summary.passing)
TESTSRAN=$(cat $FILE | jq .result.summary.testsRan)
PASSRATE=$(cat $FILE | jq .result.summary.passRate | sed 's/"//g')
DT=$( date )

echo "${PASSING}/${TESTSRAN} ${PASSRATE} ($DT)"
