-- Standard Connector operations not supported by PDaaS

--#EVENT interface addGatewayResource
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface getGatewayResource
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface updateGatewayResource
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface removeGatewayResource
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface getGatewaySettings
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface updateGatewaySettings
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface addIdentity
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface makeIdentity
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface removeIdentity
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface listTagName
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface clearContent
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface uploadContent
return require("pdaas.interface_proxy").NOT_SUPPORTED

--#EVENT interface deleteContent
return require("pdaas.interface_proxy").NOT_SUPPORTED
