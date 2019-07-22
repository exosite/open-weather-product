operation.solution_id = nil

local identityState = Device2.getIdentityState(operation)
if identityState.code ~= nil then
  return identityState
end

local configIO = require("vendor.configIO")

if configIO then
  identityState.config_io = {
    timestamp = configIO.timestamp,
    set = configIO.config_io,
    reported = configIO.config_io
  }
end

return identityState
