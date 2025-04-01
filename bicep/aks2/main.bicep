targetScope = 'subscription'

param resourceGroupName string = 'erigavo'
param resourceGroupLocation string = 'uksouth'

module rg 'resource-group.bicep' = {
  name: 'resourceGroupDeployment'
  scope: subscription() // resource group is subscription
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: resourceGroupLocation
  }
}

module aks 'aks.bicep' = {
  name: 'aksDeployment'
  scope: resourceGroup(resourceGroupName)
  params: {
    enableRBAC: true
    clusterName: 'erigavocluster'
    kubernetesVersion: '1.29.9'
    location: resourceGroupLocation
  }
  dependsOn: [
    rg
  ]
}
