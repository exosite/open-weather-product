operation.solution_id = nil
local config_io = operation.config_io
if config_io ~= nil then
  local configIOTable, err = json.parse(config_io)
  if err ~= nil then
    print("The config_io parse JSON error", err)
    operation.config_io = nil
    return Device2.setIdentityState(operation)
  else
    local configIO = require("configIO")
    configIO.set(configIOTable)
    for key, value in pairs(operation) do
      if key ~= "config_io" and key ~= "identity" then
        operation.config_io = nil
        return Device2.setIdentityState(operation)
      end
    end
    return { status = 204, status_code = 204 }
  end
end

return Device2.setIdentityState(operation)