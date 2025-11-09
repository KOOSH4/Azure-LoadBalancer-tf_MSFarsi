// main.bicep
// This is the main entry point for the deployment.
// Deploy using: az deployment group create --resource-group rg-kolad-sch --template-file bootstrap.bicep

targetScope = 'resourceGroup'

// --- Parameters ---
// These are the values you might want to change for different deployments.

// The Azure region for all resources.
param location string = 'swedencentral'

// Your GitHub repository in the format 'owner/repository'.
param githubRepo string = 'KOOSH4/Azure-LoadBalancer-tf_MSFarsi'

// The branch that will trigger deployments. Use '*' for any branch.
param githubBranch string = 'main'

// --- Variables ---

// Construct a globally unique name for the storage account.
var storageAccountName = 'sttfwsslabsec003'
var storageContainerName = 'tfstate'
var managedIdentityName = 'id-wss-lab-sec-003'

// --- Modules ---
// Calling the modular Bicep files to create the resources.

// Module to deploy the Managed Identity and Federated Credential for GitHub Actions
module managedIdentity 'modules/mi.bicep' = {
  name: 'managedIdentityDeployment'
  params: {
    location: location
    managedIdentityName: managedIdentityName
    githubRepo: githubRepo
    //githubBranch: githubBranch
  }
}

// Module to deploy the Storage Account for Terraform state
module storageAccount 'modules/st.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    location: location
    storageAccountName: storageAccountName
    storageContainerName: storageContainerName
  }
}

// --- Outputs ---
// These are the important values you'll need after deployment.

output managedIdentityName string = managedIdentity.outputs.name
output managedIdentityPrincipalId string = managedIdentity.outputs.principalId
output managedIdentityClientId string = managedIdentity.outputs.clientId
output managedIdentityResourceId string = managedIdentity.outputs.resourceId

output storageAccountName string = storageAccount.outputs.name
output storageContainerName string = storageAccount.outputs.containerName
