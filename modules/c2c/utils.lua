
local utils = {}

-- This function transform timestamp from sec/millisec into microseconds for Device2 format compatibility
function utils.getTimestamp(timestamp)
  if not timestamp then return os.time(os.date("!*t")) * 1000000
  elseif type(timestamp) ~= "number" then return os.time(os.date("!*t")) * 1000000 -- Could parse string?
  elseif timestamp < 100000000000 then return timestamp * 1000000
  elseif timestamp < 100000000000000 then return timestamp * 1000
  end
  return timestamp
end

return utils
