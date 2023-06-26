# Github Action to populate your repository from Salesforce

This action will retrieve Salesforce metadata from a Salesforce org into your Github repository.
You can schedule this action to run every night to retrieve production metadata, or any other sandbox metadata.
It uses a Github Actions matrix to run multiple retrieve operations in paralell, if required.

Here is an example which triggers retrieve every night at 1am : it retrieves all metadata from production onto the prod branch, and some metadata (defined in a package.xml) from QA sandbox into the qa branch

```
# .github/workflows/retrieve.yml
name: Retrieve Salesforce metadata
on:
  # Trigger this manually
  workflow_dispatch:
  
  # Trigger on schedule every night (1 am UTC)
  schedule:
    - cron: '00 01 * * *'

jobs:    
  oncreate:
    name: Retrieve Salesforce metadata to Github on the prod and qa branches
    
    ############################################################################################################################
    # - add branch names to be processed in the "branch" array below
    # - for each branch, create GitHub secrets for :
    #   . salesforce_url (eg https://mydomain.my.salesforce.com or https://mydomain--sdbxname.my.salesforce.com)
    #   . salesforce_sfdx_auth_url (result of this command : sfdx force:org:display --verbose --json | jq '.result.sfdxAuthUrl')

    strategy:
      matrix:
        branch: [prod, qa]
        include:
          - branch: prod
            salesforce_url:           SALESFORCE_URL_PROD
            salesforce_sfdx_auth_url: SALESFORCE_SFDXURL_PROD
            # no package_xml specified : retrieve all metadata
          - branch: qa
            salesforce_url:           SALESFORCE_URL_QA
            salesforce_sfdx_auth_url: SALESFORCE_SFDXURL_QA
            package_xml:              manifest/package-qa.xml

    ############################################################################################################################
    # Do not edit below this line

    container: salesforce/salesforcedx:7.205.6-full
    runs-on: ubuntu-latest

    steps:          
      - uses: actions/checkout@v3
        with:
          ref:                  ${{ matrix.branch }}
          persist-credentials:  false
          fetch-depth:          0

      - name: Clean local directory
        run: pwd && rm -rf force-app/*

      - name: Get Salesforce metadata from org
        uses: RupertBarrow/actions/action-populate-repo-from-salesforce@v3
        with:
         salesforce_url:            ${{ secrets[matrix.salesforce_url] }}
         salesforce_sfdx_auth_url:  ${{ secrets[matrix.salesforce_sfdx_auth_url] }}
         #package_xml:               ${{ matrix.package_xml }}
         do_git_add:                true
         do_git_commit:             true
  
      - name: Push all metadata to repo
        uses: ad-m/github-push-action@master
        with:
         github_token:  ${{ secrets.GITHUB_TOKEN }}
         branch:        ${{ matrix.branch }}
         directory:     '.'
         force:         true
```
