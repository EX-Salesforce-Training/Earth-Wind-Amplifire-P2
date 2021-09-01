# Dungeons and Dragonfire

## Project Description
This is an extension of the out-of-game dungeons and dragons project developed by team Vanquish.
In this iteration, an experience site was added with supporting Aura components to increase the 
functionality of this project.

## Technologies Used
* VS Code
* Salesforce
  * Aura Components
  * Flow Builder
  * Workflow Rules
  * SLDS
  * Apex
* Github

## Features
* Join and exit campaigns
* Create new characters connected to your user account
* Schedule new D&D sessions for your campaign
* Cancel or start a subscription plan
* Rate other users and dungeon masters
* View all parties available to be joined

## Getting Started
 * Create a fresh org
 * Go to `Setup->Digital Experience->Settings` and click "Enable Digital Experiences"
 * Clone this repo and deploy it to the org via the Salesforce CLI: `sfdx force:source:deploy -x manifest/package.xml`
 * If it deployed successfully, you should the that the DnD Realms app has been added to your org

![image](https://user-images.githubusercontent.com/52726500/131704631-38eec97c-044d-483b-97a1-1646f6f1624a.png)

## Usage
 * Once installed, you'll have to rebuild the experience site from the components provided
 * The completed experience site should look something like this (give or take any modifications you make)
![image](https://user-images.githubusercontent.com/52726500/131705149-cb144356-6657-4357-b11f-1abf0409a907.png)

## Contributors
 * Joseph Wilkerson
 * Zackary Frazier
 * Rafael Loustaunau
 * Greg Mannerberg
