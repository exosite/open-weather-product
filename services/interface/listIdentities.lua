local identities = Device2.listIdentities(operation)
if identities.code ~= nil then
  return identities
end

local configIO = require("vendor.configIO")
if configIO and next(identities.devices) ~= nil then
  for k, identity in pairs(identities.devices) do
    identities.devices[k].state.config_io = {
      timestamp = configIO.timestamp,
      set = configIO.config_io,
      reported = configIO.config_io
    }
  end
end

return identities
