#!/bin/bash

FILE=$1

PASSING=$( cat $FILE | jq .result.summary.passing)
TESTSRAN=$(cat $FILE | jq .result.summary.testsRan)
PASSRATE=$(cat $FILE | jq .result.summary.passRate | sed 's/"//g')
DT=$( date )

if [ $PASSING == 'null' ] || [ $TESTSRAN == 'null' ] || [ $PASSRATE == 'null' ]
then
  echo "ERROR ($DT)"
  exit 1
else
  echo "${PASSING}/${TESTSRAN} ${PASSRATE} ($DT)"
fi
