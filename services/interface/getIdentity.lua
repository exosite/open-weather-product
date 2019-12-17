local identity = Device2.getIdentity(operation)
if identity.error then return identity end

local configIO = require("vendor.configIO")
if configIO then
  identity.state.config_io = {
    timestamp = configIO.timestamp,
    set = configIO.config_io,
    reported = configIO.config_io
  }
end

return identity