-- Additional operations offered by PDaaS
-- Operation definition is in the /services/interface.yaml

--#EVENT interface claimDevices
return require("pdaas.interface").claimDevices(context.caller_id, operation)

--#EVENT interface getTempClaimURL
return require("pdaas.interface").getTempClaimURL(context.caller_id)

--#EVENT interface getContext
return require("pdaas.interface").getContext(context.caller_id, operation)

--#EVENT interface setContext
return require("pdaas.interface").setContext(context.caller_id, operation)
