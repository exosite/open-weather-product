local identityState = Device2.getIdentityState(operation)
if identityState.error then return identityState end

local configIO = require("vendor.configIO")
if configIO then
  identityState.config_io = {
    --change from seconds to microseconds for Exosense
    timestamp = configIO.timestamp * 1000000,
    set = configIO.config_io,
    reported = configIO.config_io
  }
end

return identityState
