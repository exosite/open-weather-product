-- This module cache value to local map
-- To be usefull this function requires the solution to enable the HotVM setting

local cache = {}
return function(key, fetcher, timeout)
  local now = os.time();
  if not cache[key] or cache[key].ts < now + (timeout or 30) then
    local value = fetcher()
    if value == nil or value.error then
      return nil
    end
    cache[key] = {
      ts = now,
      value = value
    }
  end
  return cache[key].value
end
