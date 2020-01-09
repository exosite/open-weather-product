local identities = Device2.listIdentities(operation)
if identities.error then return identities end

local configIO = require("vendor.configIO")
if configIO then
  local config_io = {
    timestamp = require("c2c.utils").getTimestamp(configIO.timestamp),
    set = configIO.config_io,
    reported = configIO.config_io
  }
  for k, identity in pairs(identities.devices) do
    identities.devices[k].state.config_io = config_io
  end
end

return identities
