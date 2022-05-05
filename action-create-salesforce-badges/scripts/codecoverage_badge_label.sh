#!/bin/bash

FILE=$1

ORGWIDECOVERAGE=` cat $FILE | jq .summary.orgWideCoverage | sed 's/"//g'`
TESTSRUNCOVERAGE=`cat $FILE | jq .summary.testRunCoverage | sed 's/"//g'`
DT=$( date )

if [ $ORGWIDECOVERAGE == 'null' ] || [ $TESTSRUNCOVERAGE == 'null' ]
then
  echo "testsrun:ERROR org:ERROR ($DT)"
  exit 1
else
  echo "testsrun:${TESTSRUNCOVERAGE} org:${ORGWIDECOVERAGE} ($DT)"
fi
