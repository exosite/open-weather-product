local t = {}

local crypto = require("pdaas.lib.crypto")

-- Auth token functions

t.token_permissions = {
  CLAIM_DEVICES_ONLY = 1,
  CREATE_APP_TOKEN = 2,
  USER_CREATION_TOKEN = 3
}

function t.createAuthToken(app_id, permission, context, minutes)
  local token = crypto.randomString(48)
  local info = {a = app_id, p = permission}
  if context then
    info.c = context
  end
  if not minutes then
    minutes = 180
  end
  local info_json = to_json(info)
  local insert = {}
  insert[1] = info_json
  insert[2] = "EX"
  insert[3] = tostring(minutes * 60)
  local app_token_key = "at_" .. token
  local result =
    Keystore.command(
    {
      key = app_token_key,
      command = "set",
      args = insert
    }
  )
  if result.error then
    return nil, e.INTERNAL
  end
  return token
end

function t.verifyToken(token, permission, app_id)
  local app_token_key = "at_" .. token
  local result =
    Keystore.command(
    {
      key = app_token_key,
      command = "get",
      args = {}
    }
  )

  if result.error then
    return nil, e.INTERNAL
  end

  if not result or not result.value then
    return nil, e.NOT_AUTHENTICATED
  end

  local info = from_json(result.value)
  if info.p ~= permission then
    return nil, e.NOT_AUTHORIZED
  end

  if app_id and info.a ~= app_id then
    return nil, e.NOT_AUTHORIZED
  end

  return info
end

function t.deleteToken(token)
  local app_token_key = "at_" .. token
  local result =
    Keystore.command(
    {
      key = app_token_key,
      command = "del",
      args = {}
    }
  )
  if result.error then
    return nil, e.INTERNAL
  end

  return true
end

return t
