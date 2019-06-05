local transform = {}

-- Below an example of transforming the GPS data values

-- function transform.convertIdentityState(state)
--   if state == nil or state.data_in == nil then
--     return state
--   end
--
--   local data_in = from_json(state.data_in)
--
--   if data_in.gps ~= nil then
--     if data_in.lat ~= nil then
--       data_in.lat = data_in.lat / 100
--     end
--     if data_in.lng ~= nil then
--       data_in.lng = data_in.lng / 100
--     end
--   end
--
--   state.data_in = to_json(data_in)
--   return state
-- end

return transform
