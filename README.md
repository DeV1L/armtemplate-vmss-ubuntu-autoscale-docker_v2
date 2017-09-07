### Autoscale container on Ubuntu 16.04 ###

VM Scale Set which install Docker and run container from Azure Container Registry. The VM Scale Set scales up when average CPU across all VMs > 70%, scales down when avg CPU < 30%.

- Login and password for ACR provides during deployment
- Deploy the scale set with an instance count of 1 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FDeV1L%2Fvmss-ubuntu-autoscale-docker_v2%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FDeV1L%2Fvmss-ubuntu-autoscale-docker_v2%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
