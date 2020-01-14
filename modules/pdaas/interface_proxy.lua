-- WARNING: Do not modify, changes will not persist updates
-- This file maps each Connector API from the interface services
-- See defined in ./services/interface/to_proxy.lua
-- Bellow functions apply namespace isolation

local ip = {}

local i = require("pdaas.interface")
local t = require("pdaas.transformers")

ip.NOT_FOUND = {
  error = "{\"message\":\"Identity not found.\"}",
  status = 404,
  type = "QueryError"
}
ip.SUCCESS = {
  status = 204
}
ip.NOT_SUPPORTED = {
  error = "{\"message\":\"Operation not supported.\"}",
  status = 403,
  type = "QueryError"
}
ip.MISSING_TAG_NAME = {
  error = "{\"message\":\"Missing tag name.\"}",
  status = 400,
  type = "QueryError"
}

function ip.getIdentity(operation)
  local device = Device2.getIdentity(operation)
  if device.error then return device end

  device = i.cleanDevice(device, context.caller_id)
  if not device then return ip.NOT_FOUND end

  if t.device2_getIdentity then
    return t.device2_getIdentity(operation, device)
  end
  return device
end

function ip.updateIdentity(operation)
  -- No data allowed from
  -- Device2.updateIdentity returns 204 when no device found
  return ip.SUCCESS
end

function ip.getIdentityState(operation)
  local device = Device2.getIdentity(operation)
  if device.error then return device end

  device = i.cleanDevice(device, context.caller_id)
  if not device then return ip.NOT_FOUND end

  if t.device2_getIdentityState then
    return t.device2_getIdentityState(operation, device.state)
  end
  return device.state
end

function ip.setIdentityState(operation)
  operation.solution_id = nil
  local device = i.isOwnerOf(context.caller_id, nil, operation.identity)
  if not device then return ip.SUCCESS end

  if t.device2_setIdentityState then
    operation = t.device2_setIdentityState(operation)
    if not operation then return ip.SUCCESS end
  end
  return Device2.setIdentityState(operation)
  -- TODO replace with setIdentities when available
end

function ip.getIdentityTag(operation)
  local device = Device2.getIdentity(operation)
  if device.error then return device end

  device = i.cleanDevice(device, context.caller_id)
  if not device then return ip.NOT_FOUND end
  if not device.tags then return from_json("[]") end

  local tags = {}
  for _, pair in ipairs(device.tags) do
    if pair.name == operation.name then
      table.insert(tags, pair.value)
    end
  end
  return tags
end

function ip.addIdentityTag(operation)
  local device = i.isOwnerOf(context.caller_id, nil, operation.identity)
  if not device or not operation.tags then return ip.SUCCESS end

  for _, pair in ipairs(operation.tags) do
    if not pair.name then return ip.MISSING_TAG_NAME end
    pair.name = "app:" .. context.caller_id .. ":" .. pair.name
  end
  return Device2.addIdentityTag(operation)
  -- TODO replace with setIdentities when available
end

function ip.removeIdentityTag(operation)
  local device = i.isOwnerOf(context.caller_id, nil, operation.identity)
  if not device then return ip.NOT_FOUND end
  if not operation.name then return ip.MISSING_TAG_NAME end

  operation.name = "app:" .. context.caller_id .. ":" .. operation.name
  return Device2.removeIdentityTag(operation)
  -- TODO replace with setIdentities when available
end

function ip.listIdentities(operation)
  operation.tag = {name = "apps", value = context.caller_id}
  local res = Device2.listIdentities(operation)
  if res.error then return res end

  for index, device in ipairs(res.devices) do
    res.devices[index] = t.device2_getIdentity(operation, i.cleanDevice(device, context.caller_id))
  end
  return res
end

function ip.countIdentities(operation)
  operation.tag = {
    name = "apps",
    value = context.caller_id
  }
  -- TODO once multi tags selection is supported
  -- if not operation.tags then operation.tags = [] end
  -- if operation.tag then table.insert(operation.tags, operation.tag) end
  -- for _, pair in ipairs(operation.tags) do
  --   pair.name = "app:" .. context.caller_id .. ":" .. pair.name
  -- end
  -- table.insert(operation.tags, {
  --   name = "apps",
  --   value = context.caller_id
  -- })
  return Device2.countIdentities(operation)
end

function ip.listContent(operation)
  if not operation.prefix then return ip.NOT_SUPPORTED end
  local identity = operation.prefix:match("device2/([^/]+)")
  if not identity then return ip.NOT_FOUND end
  local device = i.isOwnerOf(context.caller_id, nil, identity)
  if not device then return ip.NOT_FOUND end

  return Content.list(operation)
end

function ip.infoContent(operation)
  local identity = operation.id:match("device2/([^/]+)")
  if not identity then return ip.NOT_FOUND end
  local device = i.isOwnerOf(context.caller_id, nil, identity)
  if not device then return ip.NOT_FOUND end

  return Content.info(operation)
end

function ip.downloadContent(operation)
  local identity = operation.id:match("device2/([^/]+)")
  if not identity then return ip.NOT_FOUND end
  local device = i.isOwnerOf(context.caller_id, nil, identity)
  if not device then return ip.NOT_FOUND end

  return Content.download(operation)
end

return ip
