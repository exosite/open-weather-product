local cloud2murano = {}
-- This module manage data from the 3rd party

local murano2cloud = require("c2c.murano2cloud")
local cloudServiceName = murano2cloud.alias
local transform = require("vendor.c2c.transform")
local mcrypto = require("staging.mcrypto")

-- Propagate event to Murano applications
function cloud2murano.trigger(identity, event_type, payload, tags, options)
  if not options then options = {} end
    local event = {
      ip = options.ip,
      type = event_type,
      identity = identity,
      protocol = cloudServiceName,
      timestamp = options.timestamp or os.time(os.date("!*t")),
      connection_id = options.request_id or context.tracking_id,
      payload = payload,
      tags = tags
    }

    if handle_device2_event then
      handle_device2_event(event)
    end
end

function cloud2murano.provisioned(location, options)
  if not options then options = {} end
  local key = mcrypto.b64url_encode(mcrypto.rand_bytes(20))
  local r = Device2.addIdentity({ identity = location.name, auth = { key = key, type = "password" } })
  if r and r.error and r.status ~= 409 then return r end
  -- Add Fixed tags
  r = Device2.addIdentityTag({
    identity = location.name,
    replace = true,
    tags = {{
      name = "id",
      value = tostring(location.id)
    }, {
      name = "query",
      value = options.query or "N/A"
    }}
  })
  if r and r.error then return r end

  -- Emit event
  return cloud2murano.trigger(location.name, "provisioned", nil, options)
end

function cloud2murano.data_in(location, options)
  if not options then options = {} end
  local data = transform.data_in(location) -- template user customized data transforms
  if type(data) ~= table then return end

  for k, v in pairs(data) do
    local t = type(v)
    if t ~= "string" and t ~= "number" and t ~= "boolean" then data[k] = to_json(v) end
  end

  data.identity = location.name
  local r = Device2.setIdentityState(data)
  if r and r.status == 404 then
    -- Auto register device on data in
    r = cloud2murano.provisioned(location, options)
    if r and r.error then return r end
    r = Device2.setIdentityState({
      identity = location.name,
      data_in = data
    })
    if r and r.error then return r end
  end

  local payload = {{ -- a list
    values = {
      data_in = data
    },
    timestamp = (options.timestamp or os.time(os.date("!*t")))
  }}
  return cloud2murano.trigger(identity, "data_in", payload, options)
end

function cloud2murano.initDevice(identity)
  -- Get cloud data
  local location = murano2cloud.query(identity)
  if not location then return nil
  elseif location.status == 404 then
    Device2.addIdentityTag({
      identity = identity,
      replace = true,
      tags = {{
        name = "error",
        value = location.error
      }}
    })
    return location
  elseif location.error then
    return location
  end

  -- Create identity from remote cloud name
  local r = cloud2murano.provisioned(location, { query = identity })
  if r and r.error then return r end

  -- Set Weather info
  local r = cloud2murano.data_in(location, { })
  if r and r.error then return r end

  -- Remove dummy device
  if identity ~= location.name then
    return Device2.removeIdentity({ identity = identity })
  end
end

local function getIDTag(device)
  for i, tag in ipairs(device.tags) do
    if tag.name == "id" then return tag.value end
  end
end

function cloud2murano.syncAll()
  local ids = {}
  -- Scan devices from D2
  local identities = Device2.listIdentities()
  if identities.error then return identities end
  for i, device in ipairs(identities.devices) do
    local id = getIDTag(device)
    if id then
      -- Processed entry
      table.insert(ids, id)
    else
      -- Un-processed entry, init it
      cloud2murano.initDevice(device.identity)
      -- No error handling as error for a given query is reflected on the tags
    end
  end

  -- Batch fetch weather data
  local results = murano2cloud.getAll(ids)
  if not results or results.error then return results end

  -- Update state & trigger event
  for i, location in pairs(results) do
    cloud2murano.data_in(location, {})
  end
end

return cloud2murano
