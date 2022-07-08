#!/usr/bin/env bash


salesforce_sfdx_auth_url=$1
# Escapes the single quotes
subject=$(                   echo "$2" | sed -e "s/\'/\\\'/g" )
body=$(                      echo "$3" | sed -e "s/\'/\\\'/g" )
devopscenter_project_name=$( echo "$4" | sed -e "s/\'/\\\'/g" )


cd .github/workflows/sfdx-project


# Auth
echo $salesforce_sfdx_auth_url > ./sfdxauthurl.txt
sfdx force:auth:sfdxurl:store -f ./sfdxauthurl.txt -s -a checkout > /dev/null
rm -f ./sfdxauthurl.txt

# Recherche du projectid à pratir du projectname
projectid=$(sfdx force:data:soql:query -q "SELECT Id FROM sf_devops__Project__c WHERE Name='$devopscenter_project_name'"                                                         --json | jq -r '.result.records[0].Id')

# Création du work item
workitemid=$(sfdx force:data:record:create -s sf_devops__Work_Item__c -v "sf_devops__Subject__c='$subject' sf_devops__Project__c='$projectid' sf_devops__Description__c='$body'" --json | jq -r '.result.id')

# Recherche du nom du work item
workitemname=$(sfdx force:data:record:get -s sf_devops__Work_Item__c -i $workitemid                                                                                              --json | jq -r '.result.Name')


# Valeur renvoyée
echo $workitemname
