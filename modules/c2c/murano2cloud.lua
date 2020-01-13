local murano2cloud = {}
-- This module maps local changes and propagate them to the 3rd party cloud
-- The operation must follow the 3rd party service swagger definition you published from ../openweatherapi.yaml

murano2cloud.alias = "openweatherapi"

local function getQuery(identity)
  local lat, lon = string.match(identity, '(-?[0-9.]+),(-?[0-9.]+)')
  if lat and lon then return { lat = lat, lon = lon } end
  local zip = string.match(identity, '([a-zA-Z0-9.]+,[a-zA-Z-]+)')
  if zip then return { zip = zip } end
  return { q = identity }
end

-- Fetch from query
function murano2cloud.query(q)
  -- Use the new device identity to fetch the remote data
  local query = getQuery(q)
  return murano.services[murano2cloud.alias].getWeather(query)
end

local function flush(ids, acc)
  if not ids or not ids[1] then return acc end
  local r = murano.services[murano2cloud.alias].getBulkWeather({ id = ids })
  if r and r.error then return r end
  for i, element in ipairs(r.list) do
      table.insert(acc, element)
  end
  return acc
end

-- Bulk fetch from Ids
function murano2cloud.getAll(ids)
  local chunk = {}
  local acc = {}
  for i, id in ipairs(ids) do
    table.insert(chunk, id)
    if i % 20 == 0 then
      acc = flush(chunk, acc)
      if acc.error then return acc end
      chunk = {}
    end
  end
  return flush(chunk, acc)
end

return murano2cloud
