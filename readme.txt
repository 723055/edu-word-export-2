Lightning demo Application (Word Export)

Setup:

1) Login to Dev Hub org and make it default (-d key):

sfdx force:auth:web:login -d -a yourDevHubAlias



2) Create Scratch org and make it default (-s key):

sfdx force:org:create -f config/project-scratch-def.json -d 30 -s -a wordExport



3) Push project to Scratch org:

sfdx force:source:push



4) Open Scratch org in browser:

sfdx force:org:open
