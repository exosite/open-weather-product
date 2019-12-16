local cloud2murano = {}
-- This module authenticates the 3rd party cloud callback requests
-- To be updated depending on the security requirements

local cache = require("c2c.vmcache")
local murano2cloud = require("c2c.murano2cloud")
local cloudServiceName = murano2cloud.alias
local transform = require("vendor.c2c.transform")
local mcrypto = require("staging.mcrypto")

-- Propagate event to Murano applications
function cloud2murano.trigger(identity, event_type, payload, options)
    local event = {
      ip = options.ip,
      type = event_type,
      identity = identity,
      protocol = cloudServiceName,
      timestamp = options.timestamp or os.time(os.date("!*t")),
      connection_id = options.request_id or context.tracking_id,
      payload = payload
    }

    if handle_device2_event then
      handle_device2_event(event)
    end
end

function cloud2murano.provisioned(identity, data, options)
  local key = mcrypto.b64url_encode(mcrypto.rand_bytes(20))
  Device2.addIdentity({ identity = identity, auth = { key = key, type = "password" } })
  cloud2murano.trigger(identity, "provisioned", nil, options)
end

function cloud2murano.deleted(identity, data, options)
  Device2.removeIdentity({ identity = identity })
  cloud2murano.trigger(identity, "deleted", nil, options)
end

function cloud2murano.data_in(identity, data, options)
  data = transform.data_in(data) -- template user customized data transforms

  if type(data) ~= "string" then
    data = to_json(data)
  end

  result = Device2.setIdentityState({
    identity = identity,
    data_in = data
  })
  if result and result.status == 404 then
    -- Auto register device on data in
    cloud2murano.provisioned(identity, nil, options)
  end

  local payload = {{ -- a list
    values = {
      data_in = data
    },
    timestamp = (options.timestamp or os.time(os.date("!*t")))
  }}

  cloud2murano.trigger(identity, "data_in", payload, options)
end

local even_type_map = {
  data = "data_in",
  device_added = "provisioned",
  device_removed = "deleted"
  -- "connect" & "disconnect" are not fully supported as we cannot set the connection state to device2
}

-- Parse a data from 3rd part cloud into Murano event
function cloud2murano.sync(data, options)
  if not (data.identity or data.type) then
    return
  end

  local event_type = even_type_map[data.type]
  if event_type then
    return cloud2murano[event_type](data.identity, data.data, options)
  end
end

function getIdentities()
  local identities = {}
  for i, device in pairs(Device2.listIdentities().devices) do
    table.insert(identities, device.identity)
  end
  return identities
end

function cloud2murano.syncAll()
  local result = murano2cloud.sync(nil)
  if result then
    cloud2murano.data_in(result.name, result.main, {})
  end

  local identities = cache("identities", getIdentities)
  for i, identity in pairs(identities) do
    result = murano2cloud.sync(identity)
    if result then
      cloud2murano.data_in(result.name, result.main, {})
    end
  end
end

return cloud2murano
