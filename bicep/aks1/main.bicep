resource aksCluster 'Microsoft.ContainerService/managedClusters@2024-10-01' = {
  name: 'erigavocluster'
  location: resourceGroup().location
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
    dnsPrefix: 'myakscluster'
    kubernetesVersion: '1.31.6'
    enableRBAC: true
  }
}
