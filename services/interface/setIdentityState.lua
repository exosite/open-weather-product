operation.solution_id = nil
-- If config_io is hardcoded dont allow user updates
if require("vendor.configIO") then
  operation.config_io = nil
end

return Device2.setIdentityState(operation)
