#!/usr/bin/env bash

set -x


salesforce_sfdx_auth_url=$1
subject=$2
body=$3
devopscenter_project_name=$4


cd .github/workflows/sfdx-project


# Auth
echo $salesforce_sfdx_auth_url > ./sfdxauthurl.txt
sfdx force:auth:sfdxurl:store -f ./sfdxauthurl.txt -s -a checkout
rm -f ./sfdxauthurl.txt

# Recherche du projectid à pratir du projectname
projectid=$(sfdx force:data:soql:query -q "SELECT Id FROM sf_devops__Project__c WHERE Name='$devopscenter_project_name'"                                                         --json | jq '.result.records[0].Id')

# Création du work item
workitemid=$(sfdx force:data:record:create -s sf_devops__Work_Item__c -v "sf_devops__Subject__c='$subject' sf_devops__Project__c='$projectid' sf_devops__Description__c='$body'" --json | jq '.result.id')

# Recherche du nom du work item
workitemname=$(sfdx force:data:record:get -s sf_devops__Work_Item__c -i $workitemid                                                                                              --json | jq '.result.Name')


# Valeur renvoyée
echo $workitemname
