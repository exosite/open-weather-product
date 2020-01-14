-- WARNING: Do not modify, changes will not persist updates

local d = {}

function d.setClaimCode(device_id, claim_code, expire_hours)
  local expire_time = 0
  if expire_hours then
    expire_time = os.time(os.date("!*t")) + expire_hours * 60 * 60
  end
  if not claim_code then
    claim_code = device_id
  end
  local t = {}
  t[1] = {name = "claim_code", value = claim_code}
  if expire_time > 0 then
    t[2] = {name = "expires", value = tostring(expire_time)}
  end
  Device2.addIdentityTag({identity = device_id, tags = t, replace = true})
  return claim_code
end

function d.resetDevice(device_id, expire_hours)
  local expire_time = 0
  if expire_hours then
    expire_time = os.time(os.date("!*t")) + expire_hours * 60 * 60
  end
  local device = Device2.getIdentity({identity = device_id})
  -- Return error
  if device.error then
    return device
  end

  local tags = device.tags or {}
  for _, tag in ipairs(tags) do
    if string.find(tag.name, "contex_") ~= nil then
      Device2.removeIdentityTag({identity = device_id, name = tag.name})
    end
  end

  Device2.removeIdentityTag({identity = device_id, name = "apps"})
  Device2.removeIdentityTag({identity = device_id, name = "users"})
  Device2.removeIdentityTag({identity = device_id, name = "expires"})
  if expire_time > 0 then
    local t = {}
    t[1] = {name = "expires", value = tostring(expire_time)}
    Device2.addIdentityTag({identity = device_id, tags = t, replace = true})
  end

  return claim_code
end

function d.addToDevices(precontag, toaddtags)
  local query = {limit = 5000}
  query.tag = precontag
  local res = Device2.listIdentities(query)
  for _, device in ipairs(res.devices) do
    local device_id = device.identity
    Device2.addIdentityTag({identity = device_id, tags = toaddtags})
  end
end

function d.removeFromDevices(precontag, toremovetags)
  local query = {limit = 5000}
  query.tag = precontag
  local res = Device2.listIdentities(query)
  local removetags = {}
  for i, v in ipairs(toremovetags) do
    local name = v.name
    local val = v.value
    local existing = removetags[name]
    if existing then
      removetags[name] = existing .. "," .. val
    else
      removetags[name] = val
    end
  end

  for _, device in ipairs(res.devices) do
    local device_id = device.identity
    for k, v in pairs(removetags) do
      Device2.removeIdentityTag({identity = device_id, name = k, value = v})
    end
  end
end

function d.count(user_email)
  -- Current queries only support 1 tag see discussion on MUR-10083
  -- return Device2.countIdentities({
    -- tag: {{name = "users", value = user_email}, {name = "apps", value = app}}
  -- })
  local result = Device2.listIdentities({tag = {name = "users", value = user_email}})
  if result.error then
    return result
  end
  local apps = {}
  for i, d in ipairs(result.devices) do
    for j, t in ipairs(d.tags) do
      if t.name == "apps" then
        apps[t.value] = apps[t.value] and apps[t.value] + 1 or 1
      end
    end
  end
  return apps
end

function d.addApps(device_id, app_ids)
  local tags = {}
  for _, app_id in ipairs(app_ids or {}) do
    table.insert(tags, {name = "apps", value = app_id})
  end
  Device2.addIdentityTag({identity = device_id, tags = tags})
end

function d.removeApps(device_id, app_ids)
  for _, app_id in ipairs(app_ids or {}) do
    Device2.removeIdentityTag({identity = device_id, name = "apps", value = app_id})
  end
end

function d.setOwnership(device_id, user_emails, app_ids, contexts)
  local tags = {}
  for _, app_id in ipairs(app_ids) do
    local context = contexts[idx]
    if app_id and context and type(context) == "string" and string.len(context) < 256 then
      table.insert(tags, {name = "context_" .. app_id, value = context})
    end
    table.insert(tags, {name = "apps", value = app_id})
  end
  for idx, user_email in ipairs(user_emails) do
    table.insert(tags, {name = "users", value = user_email})
  end


  return Device2.addIdentityTag({identity = device_id, tags = tags})
end

function d.claimDevices(claim_codes, user_emails, app_ids, contexts)
  local user_emails = user_emails or {}
  if type(user_emails) == "string" then
    user_emails = {user_emails}
  end
  local app_ids = app_ids or {}
  if type(app_ids) == "string" then
    app_ids = {app_ids}
  end
  local contexts = contexts or {}
  if type(contexts) == "string" then
    contexts = {contexts}
  end

  if type(claim_codes) == "string" then
    claim_codes = {claim_codes}
  end
  local result = {}
  for _, claim_code in ipairs(claim_codes) do
    local query = {limit = 5000}
    query.tag = {name = "claim_code", value = claim_code}
    local res = Device2.listIdentities(query)
    local now = os.time(os.date("!*t"))
    for _, device in ipairs(res.devices) do
      local device_id = device.identity
      result[device_id] = {}
      local expires = 0
      local claimed = false
      local tags = device.tags or {}
      for _, tag in ipairs(tags) do
        if tag.name == "expires" then
          expires = tonumber(tag.value)
        elseif tag.name == "apps" or tag.name == "users" then
          claimed = true
        end
      end

      if claimed then
        result[device_id].error = "Device already claimed"
      elseif expires > 0 and expires < now then
        result[device_id].error = "Claim code expired"
      else
        Device2.removeIdentityTag({identity = device_id, name = "apps"})
        Device2.removeIdentityTag({identity = device_id, name = "users"})
        Device2.removeIdentityTag({identity = device_id, name = "expires"})

        d.setOwnership(device_id, user_emails, app_ids, contexts)
      end
    end
  end
  return result
end

return d
