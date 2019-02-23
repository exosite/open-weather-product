operation.solution_id = nil
local identity = operation.identity

-- This should not exist and need to be replaced by Device2.setIdentityState: MUR-8916
local resources = operation
resources.identity = nil
local ret = Sigfox.setProductResources({
  productId = context.solution_id, -- This should be optional
  deviceId = identity,
  productResources = resources
})
if ret.error ~= nil then
  return ret
end

-- if operation.data_out ~= nil then
--   -- This should get mapped automatically with a config
--   -- resource -> downlinkdata
--   -- HERE NEED A MAPPING BETWEEN EXOSENSE data_out & downlinkData
--   local downlinkData = operation.data_out
--
--   local ret = Sigfox.sendDownlinkData({
--     apiUser = "<your Sigfox api user name>", -- This should be optional
--     productId = context.solution_id, -- This should be optional
--     deviceTypeId = "donotchange",
--     downlinkData = {identity, downlinkData}
--   })
--
--   if ret.error ~= nil then
--     return ret
--   end
-- end

return Device2.setIdentityState(operation)
