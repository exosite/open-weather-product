
-- This file enable device data transformation for the template user
--
-- This file is in the 'vendor' safeNamespace and changes will persists upon template updates

local transforms = {
  temperature = function(value)
    -- Example of value provided as 2 digits float sent by device as an integer
    -- Eg 2050 -> 20.50
    return value / 100
  end
}

local tf = {}

-- The event is the object provided by the Device2 event: http://docs.exosite.com/reference/services/device2/#event
-- function tf.device2_event(event)
--   if event.payload then
--     for _, data in ipairs(event.payload) do
--       for resource, value in pairs(data) do
--         if transforms[resource] then
--           data[resource] = transforms[resource](value)
--         end
--       end
--     end
--   end
--   return {event}
--   -- return {eventA, eventB} you can return multiple events
-- end

-- Same state transform applied when Apps actively fetch the state with:
-- getIdentityState: http://docs.exosite.com/reference/services/device2/#getidentitystate
-- function tf.device2_getIdentityState(query, response)
--   for resource, value in pairs(response) do
--     if value.reported and transforms[resource] then
--       data[resource].reported = transforms[resource](value.reported)
--     end
--   end
--   return response
-- end

-- For getIdentity: http://docs.exosite.com/reference/services/device2/#getidentity
-- & listIdentities http://docs.exosite.com/reference/services/device2/#listidentities
-- function tf.device2_getIdentity(query, response)
--   response.state = tf.device2_getIdentityState(query, response.state)
--   return response
-- end

return tf
