# Github actions for Salesforce, by Devoteam

Salesforce DevOps on Github, by Devoteam


## Objectives

Set up very easy tooling for Salesforce Devops, on Github, requiring absokutely no technical Knowledge :
- very easily initialize a Github repository with Salesforce metadata (code, configuration, objects, fields etc.) from production
- initialize a Github branch for each major sandbox of the delivery cycle (DEV, INT, UAT)
- automatically retrieve changes in PROD, UAT, INT, DEV into Github, so nothing is lost
- automatically run tests every night in each org, and display badges for test results, code coverage, PMD analysis and health check

Coming soon :
- automatic integration of changes from a branch to INT, from INT to UAT
- assisted deployment to production
- visual code coverage directly in Github source code file annotations
- developer assistance with for tests, code coverage
- packaging strategy to break down existing Salesforce orgs into modular packages

## 1. First stage : create a new Github repository for your Salesforce project

### Use case 1 : an existing customer asks you to start moving towards Salesforce DX where Github is the reference, not the org
### Use case 2 : you start working with a Salesforce customer who already has Salesforce
### Use case 3 : you are working for an existing customer who has not asked for anything, but you want to put thing under control of Github

1. Get a Github account and join the DevoteamDCE organization : https://github.com/join
2. Get the username, password and security token of an admin user in the customer's Salesforce production org
3. Check whether we have already created a repository for the customer : under DevoteamDCE (https://github.com/DevoteamDCE) look for a repository called client-<clientName>. If it already exists, got to the next step
4. Create a new repository if it does not already exist : click New (new repository, at https://github.com/organizations/DevoteamDCE/repositories/new), choose template=DevoteamDCE/sfdx-devoteam-template, name the repository client-<clientName> (with no spaces in the name), keep it private, click "Create repository".

Congratulations, you now have a new, clean but "empty" Salesforce repository.
Let's populate it with Salesforce metadata, i.e. code, configuration etc. from production.


## 2. Second Stage : populate the Github repository with Salesforce metadata, code and configuration from production

### Salesforce credentials

Save the Salesforce credentials in secrets (secret variables) : in the repository, go to th Settings tab, then the Secrets menu item on the left, and create 4 secrets :
  - ```SALESFORCE_URL``` : the domain url of the org, i.e. ```https://login/salesforce.com``` for production or ```https://test.salesforce.com``` for a sandbox
  - ```SALESFORCE_USERNAME``` : the username of the admin
  - ```SALESFORCE_PASSWORD``` : the password of the admin, concatenated with the Salesforce security key
  - ```GITHUB_TOKEN``` : create your own Github personal access token (https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) and put it here


### Branch "prod"

The default branch Github works on is "main".
From "main", create a branch called "prod" : https://docs.github.com/en/free-pro-team@latest/desktop/contributing-and-collaborating-using-github-desktop/managing-branches#creating-a-branch
- make sure that you are on the "main" branch
- create a new branch called "prod"
- now make sure you are on the "prod" branch

### Package.xml

The template is initialized with a standard file called "manifest/package.xml" which lists the metadata you want to retrieve from production.
If you want to change this list and if you know what you are doing, then update this file now.
If not, don't worry, you can change this later,, if necessary. The default template is OK.

### Last step : trigger the retrieve operation

In the Github repository, check that you are on the "prod" branch. Now, navigate to the file called  ```.github/commands/command-retrieve-salesforce-org-to-github.txt```.

Edit the file by clicking on the pencil, on the right.
Replace its contents with ```branch=prod```.

Before saving, check that you are on the prod branch; if not, cancel.
If you are on the prod branch, click "Commit changes"

### Congratulations : automatic retrieve is starting !
Congratulations !
The metadata from Salesforce (code, configuration, etc.) is being automatically retrieved from Production and will be saved to Github in the prod branch of thie repository.

If you want to track what is going on, open the Actions tab and follow the operations.
At the end, you can navigate to the folder called ```force-app/force-app/main/default``` and see what has been retrieved : code in the classes folder, Visualforce pages in the pages folder, Apex triggers in the triggers folder, etc.

### NB : if you want to add this feature to an existing repository ...

First, copy the following files from the Devoteam template ```sfdx-devoteam-template```to your repository :
- the whole ```.github``` folder
- the ```manifest/package.xml``` file, if you do not already have one

Now you call follow all the steps of this Second Stage chapter