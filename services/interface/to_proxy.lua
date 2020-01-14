-- Exposed operations to be relayed

--#EVENT interface getIdentity
return require("pdaas.interface_proxy").getIdentity(operation)

--#EVENT interface updateIdentity
return require("pdaas.interface_proxy").updateIdentity(operation)

--#EVENT interface getIdentityState
return require("pdaas.interface_proxy").getIdentityState(operation)

--#EVENT interface setIdentityState
return require("pdaas.interface_proxy").setIdentityState(operation)

--#EVENT interface getIdentityTag
return require("pdaas.interface_proxy").getIdentityTag(operation)

--#EVENT interface addIdentityTag
return require("pdaas.interface_proxy").addIdentityTag(operation)

--#EVENT interface removeIdentityTag
return require("pdaas.interface_proxy").removeIdentityTag(operation)

--#EVENT interface listIdentities
return require("pdaas.interface_proxy").listIdentities(operation)

--#EVENT interface countIdentities
return require("pdaas.interface_proxy").countIdentities(operation)

--#EVENT interface listContent
return require("pdaas.interface_proxy").listContent(operation)

--#EVENT interface infoContent
return require("pdaas.interface_proxy").infoContent(operation)

--#EVENT interface downloadContent
return require("pdaas.interface_proxy").downloadContent(operation)
