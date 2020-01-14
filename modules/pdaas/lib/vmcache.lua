-- This module cache value to local map
-- To be usefull this function requires the solution to enable the HotVM setting

-- TODO add size limitations/lru/background deletion options
local cache = {}
function cache.get(key, getter, timeout)
  local now = os.time()
  if not cache[key] or cache[key].ex < now then
    local value
    if getter then
      value = getter(key)
    else
      value = Keystore.get({key = key})
      if value and value.value then
        value = value.value
      end
    end
    if value == nil or value.error or (type(value) == "table" and #value <= 0) then
      cache[key] = nil
      return nil
    end
    cache[key] = {
      ex = now + (timeout or 30), -- Expires
      value = value
    }
  end
  return cache[key].value
end

function cache.set(key, value, timeout, setter)
  if cache[key] == value then
    return
  end

  local result
  if setter then
    result = setter(key, value)
  else
    result =
      Keystore.command(
      {
        key = key,
        command = "set",
        args = {value, "EX", (timeout or 30)}
      }
    )
  end
  if result and result.error then
    return nil
  end
  cache[key] = {
    ex = os.time() + 30, -- Expires
    value = value
  }
  return value
end

return cache
