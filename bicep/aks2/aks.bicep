@description('enable RBAC')
param enableRBAC bool = true

@description('name of the cluster')
param clusterName string = 'erigavocluster'

@description('Kubernetes version')
@allowed([
  '1.29.9'
  '1.28.12'
  '1.27.16'
]) // supported versions as of early 2025
param kubernetesVersion string

@description('Location for the AKS cluster')
param location string = resourceGroup().location

resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-11-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: 1
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        mode: 'System'
      }
    ]
    dnsPrefix: '${clusterName}-dns'
    kubernetesVersion: kubernetesVersion
    enableRBAC: enableRBAC
  }
}
