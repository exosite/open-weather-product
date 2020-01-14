-- WARNING: Do not modify, changes will not persist updates

local i = {}

local a = require("pdaas.apps")
local u = require("pdaas.users")
local d = require("pdaas.devices")
local t = require("pdaas.transformers")
local to = require("pdaas.lib.tokens")

function i.handleAPIOperations(device_id, data, tags)
  if data.pdaas_reset then
    local ok, error = d.resetDevice(device_id)
    if error ~= nil then
      log.error("DeviceAPI: Failed to reset device ownership for device " .. device_id, error)
    end
    Device2.setIdentityState({identity = device_id, ["pdaas_user_reset"] = error or "true"})
  elseif data.pdaas_claim_code then
    local ok, error = d.setClaimCode(device_id, data.pdaas_claim_code)
    if error ~= nil then
      log.error("DeviceAPI: Failed to set claim code for device " .. device_id, error)
    end
    Device2.setIdentityState({identity = device_id, ["pdaas_claim_code"] = error or "true"})
  elseif data.pdaas_user_email then
    for _, tag in ipairs(tags) do
      if tag.name == "users" then
        -- Device has an owner already
        return Device2.setIdentityState({identity = device_id, ["pdaas_user_email"] = "Already Owned"})
      end
    end

    local email = data.pdaas_user_email
    local ok, error = u.signup(email)

    if error ~= nil then
      log.error("Failed to signup user " .. email .. " for device " .. device_id, error)
      return Device2.setIdentityState({identity = device_id, ["pdaas_user_email"] = error})
    end

    local ok, error = d.setOwnership(device_id, {email})

    if error ~= nil then
      log.error("Failed to set device " .. device_id .. " ownership", error)
      return Device2.setIdentityState({identity = device_id, ["pdaas_user_email"] = error})
    end

    Device2.setIdentityState({identity = device_id, ["pdaas_user_email"] = "true"})
  end
end

function i.handleEvent(event)
  local apps = {}
  if event.type == "provisioned" then
    d.setClaimCode(event.identity)
  elseif event.type == "data_in" and event.payload[1] then
    i.handleAPIOperations(event.identity, event.payload[1].values, event.tags)
  end

  -- Handle PDaaS meta-data
  if event.tags then
    for _, tag in ipairs(event.tags) do
      if tag.name == "apps" then
        table.insert(apps, tag.value)
      end
    end
  end

  if event.payload then
    event.payload = i.cleanPayload(event.payload)
  end

  -- Apply user transforms
  local events = t.device2_event(event)

  -- Send to apps
  local tags
  for _, app_id in ipairs(apps) do
    local t = a.getType(app_id)
    if t == a.types.EXTERNAL_HTTPS then
      a.httpTrigger(app_id, events)
    else
      -- Murano app
      for _, event in ipairs(events) do
        tags = event.tags
        event = i.cleanTags(event, app_id)
        Interface.triggerOne({event = "event", data = event, target = app_id, mode = "async"})
        event.tags = tags
      end
    end
  end
end

function i.updateDescription()
  if global_domain == nil then
    local webservice = Config.getParameters({service = "webservice"})
    global_domain = webservice.parameters.domain -- global cached by hotvm
  end
  local desc = "To manage and claim new devices, please login at https://" .. global_domain
  Config.setParameters({service = "interface", parameters = {description = desc}})
end

-- PDaaS API functions

function i.claimDevices(app_id, operation)
  return d.claimDevices(operation.codes, nil, app_id, operation.context)
end

function i.getTempClaimURL(app_id, operation)
  local context = operation.context
  if context then
    if type(context) ~= "string" then
      return nil, 3 -- TODO define error codes
    end
    if string.len(context) > 256 then
      return nil, 4 -- TODO define error codes
    end
  end
  local token, err = to.createAuthToken(app_id, to.token_permissions.CLAIM_DEVICES_ONLY, context, 120)
  if err ~= nil then
    return nil, err
  end
  local webservice = Config.getParameters({service = "webservice"})
  local url = "https://" .. webservice.parameters.domain .. "/#/qrscan?session=" .. token
  return url
end

-- TODO: Replace with conditional update on Device2 service when avaliable
function checkDeviceOwnership(app_id, user_email, device_id)
  local device = Device2.getIdentity({identity = device_id})
  -- Return error
  if device.error then
    return nil, device.error
  end
  local tags = device.tags or {}
  for _, tag in ipairs(tags) do
    if tag.name == "apps" and tag.value == app_id then
      return device
    end
    if tag.name == "users" and tag.value == user_email then
      return device
    end
  end
  return nil
end

function i.isOwnerOf(app_id, user_email, device_id)
  return checkDeviceOwnership(app_id, user_email, device_id)
end

local function starts_with(str, start)
  return str:sub(1, #start) == start
end

function i.cleanTags(device, app_id)
  if not device or not device.tags or not app_id then return nil end
  local prefix = "app:" .. app_id .. ":"
  local cleaned = {}
  local owned = false
  for i, pair in ipairs(device.tags) do
    if pair.name == "apps" and pair.value == app_id then
      owned = true
    elseif starts_with(pair.name, prefix) then
      pair.name = pair.name:sub(#prefix + 1)
      table.insert(cleaned, pair)
    end
  end
  device.tags = cleaned
  return owned and device
end

function i.setTags(tags, app_id)
  if not app_id then app_id = context.caller_id end
  if not (tags and app_id) then return nil end
  local prefix = "app:" .. app_id .. ":"
  for i, pair in ipairs(tags) do
    pair.name = prefix .. pair.name
  end
  return tags
end

function i.cleanState(state)
  state.pdaas_reset = nil
  state.pdaas_user_email = nil
  state.pdaas_claim_code = nil
  return state
end

function i.cleanPayload(payload)
  for _, state in ipairs(payload) do
    i.cleanState(state)
  end
  return payload
end

function i.cleanDevice(device, app_id)
  local device = i.cleanTags(device, app_id)
  if not device then return nil end

  return {
    state = i.cleanState(device.state),
    lastip = device.lastip,
    online = device.online,
    identity = device.identity,
    lastseen = device.lastseen,
    tags = device.tags
  }
end

function i.setContext(app_id, operation)
  local context = operation.context
  local device_id = operation.device_id
  local device = checkDeviceOwnership(app_id, nil, device_id)
  if device ~= nil then
    if context == nil then
      Device2.removeIdentityTag({identity = device_id, name = "context_" .. app_id})
    else
      tags = {{name = "context_" .. app_id, value = context}}
      Device2.addIdentityTag({identity = device_id, tags = tags, replace = true})
    end
  end
end

function i.getContext(app_id, operation)
  local device_id = operation.device_id
  local device = checkDeviceOwnership(app_id, nil, device_id)
  local tagname = "context_" .. app_id
  if device ~= nil then
    local tags = device.tags or {}
    for _, tag in ipairs(tags) do
      if tag.name == tagname then
        return tag.value
      end
    end
  end
  return nil
end

return i
