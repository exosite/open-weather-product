-- This module defines a proxy on Device2 access to do the syncronisation with the remote cloud
local d2 = { }
local murano2cloud = require("c2c.murano2cloud")

-- Define as follow the device2 functions to overload
function d2.addIdentity(operation)
  local cloudResult = murano2cloud.addIdentity(operation.identity)
  if cloudResult and cloudResult.error then
    return cloudResult
  end
  return murano.services.device2.setIdentityState(operation)
end
function d2.removeIdentity(operation)
  local cloudResult = murano2cloud.removeIdentity(operation.identity)
  if cloudResult and cloudResult.error then
    return cloudResult
  end
  return murano.services.device2.setIdentityState(operation)
end
function d2.setIdentityState(operation)
  local identity = operation.identity
  operation.identity = nil
  local result = murano.services.device2.setIdentityState(operation)
  if result and result.error then
    return result
  end
  local cloudResult = murano2cloud.setIdentityState(identity, operation)
  if cloudResult and cloudResult.error then
    return cloudResult
  end
  return result
end

-- Other function get proxy to original behavior
setmetatable(d2, {
  __index = function(t, k)
    return murano.services.device2[k]
  end
})
_G["Device2"] = d2
-- There is no return function so this code get executed at each VM load without use of 'require'
