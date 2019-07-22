operation.solution_id = nil
operation.config_io = nil -- ready only as set in vendor.configIO

local result = Device2.setIdentityState(operation)

local identity = operation.identity
operation.identity = nil

require("murano2cloud").setIdentityState(identity, operation)

return result
