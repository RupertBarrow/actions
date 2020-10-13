#!/bin/bash

ORGWIDECOVERAGE=` cat ./reports/codecoverage.json | jq .result.summary.orgWideCoverage | sed 's/"//g'`
TESTSRUNCOVERAGE=`cat ./reports/codecoverage.json | jq .result.summary.testRunCoverage | sed 's/"//g'`
DT=$( date )

echo "testsrun:${TESTSRUNCOVERAGE} org:${ORGWIDECOVERAGE} ($DT)"
