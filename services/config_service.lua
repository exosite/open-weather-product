
local murano2cloud = require("murano2cloud").alias

-- This event listen to the changes made on the Service configuration to react to user setting change
if service.service == murano2cloud.alias and (service.action == "added" or service.action == "updated") then
  if (service.parameters.callback_token) then
    -- User changed the token save it.
    require("authentication").setToken(service.parameters.callback_token)
  end
end
