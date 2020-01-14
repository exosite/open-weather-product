-- WARNING: Do not modify, changes will not persist updates

local t = {}

local vendortf = require("vendor.transform") or {}

-- Return a list of events, event filtering and event multiplications
function t.device2_event(event)
  -- plan deprecation of vendortf.transform
  local transform_f = vendortf.device2_event or vendortf.transform
  if transform_f then
    return vendortf.device2_event(event)
  end
  return {event}
end

function t.device2_getIdentityState(query, response)
  if vendortf.device2_getIdentityState then
    return vendortf.device2_getIdentityState(query, response)
  end
  return response
end

function t.device2_getIdentity(query, response)
  if vendortf.device2_getIdentity then
    return vendortf.device2_getIdentity(query, response)
  end
  return response
end

return t
