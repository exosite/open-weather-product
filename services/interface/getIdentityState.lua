local identityState = Device2.getIdentityState(operation)
if identityState.error then return identityState end

local configIO = require("vendor.configIO")
if configIO then
  identityState.config_io = {
    timestamp = require("c2c.utils").getTimestamp(configIO.timestamp),
    set = configIO.config_io,
    reported = configIO.config_io
  }
end

return identityState
