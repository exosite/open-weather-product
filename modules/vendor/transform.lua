local transform = {}

-- Below an example of transforming the GPS data values

-- function convertGps(data_in_source)
--   local data_in, err = from_json(data_in_source)
--   if err ~= nil then
--     return data_in_source
--   end

--   if data_in.gps ~= nil then
--     if data_in.gps.lat ~= nil then
--       data_in.gps.lat = data_in.gps.lat / 1000000
--     end
--     if data_in.gps.lng ~= nil then
--       data_in.gps.lng = data_in.gps.lng / 1000000
--     end
--   end

--   return to_json(data_in)
-- end

-- function transform.convertIdentityState(state)
--   if state == nil or state.data_in == nil then
--     return state
--   end

--   if state.data_in.reported == nil then
--     state.data_in = convertGps(state.data_in)
--   else
--     state.data_in.reported = convertGps(state.data_in.reported)
--     state.data_in.set = convertGps(state.data_in.set)
--   end

--   return state
-- end

return transform
