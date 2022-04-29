#!/bin/bash

# Install SFpowerkit plugin, and log in
echo 'y' | sfdx plugins:install sfpowerkit

#https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
while getopts ":l" option; do
   case $option in
      l) # login url
         sfdx_auth_url=$2
         shift
         ;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit
         ;;
   esac
done

echo $sfdx_auth_url > ./sfdxauthurl.txt
sfdx force:auth:sfdxurl:store -f ./sfdxauthurl.txt
rm -f ./sfdxauthurl.txt
#sfdx sfpowerkit:auth:login -a checkout $*
sfdx force:config:set defaultusername=checkout        

# Retrieve metadata from Salesforce org
#sfdx force:source:retrieve -x ./manifest/package.xml
#cd ./force-app/main/default/staticresources
#find . -name .git -type d -exec rm -rf {} \; || true
#cd ../../../../


mkdir -p ./reports

# Run Apex PMD Static (Code Analyzer)
touch ./reports/pmd.json
sfdx sfpowerkit:source:pmd -d ./force-app/main/default -r category/apex/design.xml -f json -o ./reports/pmd.json || true

# Run Code Coverage
touch ./reports/codecoverage.json
touch ./reports/codecoverage.txt
$( sfdx force:apex:test:run -c -u checkout -r json  > ./reports/codecoverage.json ) || true
$( sfdx force:apex:test:run -c -u checkout -r human > ./reports/codecoverage.txt  ) || true

# Run Health Check
touch ./reports/healthcheck.json
$( sfdx sfpowerkit:org:healthcheck --json > ./reports/healthcheck.json ) || true


#########################################################################################################
# Commit test reports to Git and sync back to Github.
# Following this, the create-test-badges-v2.yml action will run to generate the badge labels
# These badges are displayed in the REAM file of this repo

pwd
git config --local user.email "action@github.com"
git config --local user.name  "GitHub Action"
git add ./reports/pmd.json
git add ./reports/codecoverage.json
git add ./reports/codecoverage.txt
git add ./reports/healthcheck.json
git commit -m "Auto-generated test, code coverage, PMD and health check reports" || true
