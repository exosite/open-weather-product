-- Event to manage Murano solution configured to the PDaaS

--#EVENT interface subscriberAdded
return nil

--#EVENT interface subscriberUpdated
local claim_code = subscription.parameters.claim_code
if not claim_code or claim_code == "" or claim_code:sub(1, 1) == '<' then
  return nil
end

local devices = require("pdaas.devices").claimDevices(claim_code, nil, subscription.solution_id)
if not devices then devices = {} end

local n=0
for k,v in pairs(devices) do
  if not v.error then n=n+1 end
end

-- Response is set back to subscriber parameters
return {
  parameters = {
    claim_code = "<" .. n .. " device(s) added>"
  }
}

--#EVENT interface subscriberRemoved
-- Do not remove the app trace, in the app was removed by mistack it can be added back.
return nil
