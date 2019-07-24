
-- This event listen to the changes made on the Service configuration to react to user setting change
if service.service == require("c2c.murano2cloud").alias and (service.action == "added" or service.action == "updated") then

  local result = Config.getParameters({service = service.service})
  if (result.parameters.appid) then
    -- User changed the token: resync

    require("c2c.cloud2murano").syncAll()
  end
end
