#!/bin/bash

set -x

FILE=$1

ORGWIDECOVERAGE=` cat $FILE | jq .result.summary.orgWideCoverage | sed 's/"//g'`
TESTSRUNCOVERAGE=`cat $FILE | jq .result.summary.testRunCoverage | sed 's/"//g'`
DT=$( date )

if [ $ORGWIDECOVERAGE == 'null' ] || [ $TESTSRUNCOVERAGE == 'null' ]
then
  echo "ERROR ($DT)"
  exit 1
else
  echo "testsrun:${TESTSRUNCOVERAGE} org:${ORGWIDECOVERAGE} ($DT)"
fi
