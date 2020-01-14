-- WARNING: Do not modify, changes will not persist updates

local a = {}

local h = require("pdaas.lib.helper")
local c = require("pdaas.lib.vmcache")
local ft = require("pdaas.lib.flat_table")
local ks = require("pdaas.lib.keystore")
local crypto = require("pdaas.lib.crypto")
local d = require("pdaas.devices")
local e = require("pdaas.lib.errors")

-- Types
local types = {
  MURANO = 1,
  EXTERNAL_HTTPS = 2
  -- SERVICE -- Add service app type?
}

a.types = types

local external_app_schema = {
  n = ft.string, -- Name
  o = ft.string, -- Owner email
  d = ft.string, -- Description
  l = ft.string, -- Logo url
  u = ft.string, -- Url
  td = {
    c = ft.string, -- Callback Url
    s = ft.string, -- Secret used for interface API
    t = ft.string, -- Type: basic | token
    tp = ft.string -- Token prefix to add before the secret eg. token or bearer
  }
}

-- Schema to get minimal information needed to send device data to external app
local external_routinginfo_schema = {
  td = external_app_schema.td
}

-- Private API

function a.getType(app_id)
  local prefix = string.sub(app_id, 0, 4)
  if prefix == "ext_" then
    return types.EXTERNAL_HTTPS
  else
    return types.MURANO
  end
end

-- Get basic app infomation
function a.info(app_id)
  local t = a.getType(app_id)
  if t == types.EXTERNAL_HTTPS then
    local app, err = ks.getHashFields(app_id, external_app_schema)
    if err then return nil, err end
    local l_status = c.get("a_st_" .. app_id)
    local l_err = c.get("a_err_" .. app_id)
    return {
      name = app.n,
      description = app.d,
      logo = app.l,
      url = app.u,
      owner = app.o,
      type = types.EXTERNAL_HTTPS,
      tr_st = l_status,
      tr_err = l_err,
      td = {
        c = app.td.c,
        t = app.td.t,
        tp = app.td.tp
      }
    }
  else
    local result = Interface.getSubscriber({subscriber_id=app_id})
    if result.error then
      if result.status == 404 then
        return {
          id = id,
          name = app_id,
          c = 0,
          type = types.MURANO
        } -- Application has been removed from the product
      end
      return nil, e.get(500, "Unable to get subscriber")
    end
    local info = (result.parameters or {}).app_info or {}
    local name = app_id
    if info.name and string.len(info.name) >= 2 then
      name = info.name
    end
    if info.url and info.url ~= "" then
      if not string.match(info.url, '^https?://.*') then
        info.url = "https://" .. info.url
      end
    else
      if global_domain == nil then
        local webservice = Config.getParameters({service = "webservice"})
        global_domain = webservice.parameters.domain -- global cached by hotvm
      end
      local domain = string.match(global_domain, '[^.]+(.*)$')
      if domain then info.url = "https://" .. app_id .. domain end
    end

    return {
      id = app_id,
      name = name,
      c = 1,
      type = types.MURANO,
      description = info.description,
      url = info.url,
      logo = info.logo_url
    }
  end
end

function a.verifySecret(app_id, secret)
  local t = a.getType(app_id)
  if t ~= types.EXTERNAL_HTTPS then
    return nil, e.NOT_AUTHENTICATED
  end
  local app, error = ks.getHashFields(app_id, {td = {s = ft.string}})
  if error then
    return nil, error
  end
  local td = app.td or {}
  if td.s and td.s == secret then
    return {app_id = app_id}
  else
    return nil, e.NOT_AUTHENTICATED
  end
end

function a.getExternalApp(app_id)
  local app, err = ks.getHashFields(app_id, external_app_schema)
  if err ~= nil then
    return nil, err
  end
  if app.n == ks.null then
    return nil
  end
  return app
end

function a.isOwner(user, app_id)
  local t = a.getType(app_id)
  if t ~= types.EXTERNAL_HTTPS then
    return false
  end
  local app, err = ks.getHashFields(app_id, { o = ft.string })
  if err ~= nil then
    return nil, e.get(500, "Internal error")
  end
  if app.o == user then
    return true
  end
  return false
end

function a.createExternalApp(app)
  local app_id = "ext_" .. crypto.randomString(12)
  if not app.n or app.n == '' then
    app.n = app_id
  end
  local _, err = ks.setHashFields(app_id, app)
  if err then
    return nil, err
  end

  return {token = app.td.s, app_id = app_id}
end

local function updateExternalApp(app_id, data)
  local app, err = a.getExternalApp(app_id)

  if err then
    return nil, err
  end

  if not app then
    return nil, e.get("NOT_FOUND", app_id)
  end

  app.n = data.n or data.name or data.app_info and data.app_info.name or app.n
  app.d = data.d or data.description or app.d
  app.l = data.l or data.logo or app.l
  app.u = data.u or data.url or app.u

  if data.td then
    app.td.c = data.td.c or app.td.c
    app.td.t = data.td.t or app.td.t
    app.td.s = data.td.s or app.td.s
    app.td.tp = data.td.tp or app.td.tp
    app.td.tv = data.td.tv or app.td.tv
  end

  return ks.setHashFields(app_id, app)
end

-- Only used for external apps
function a.httpTrigger(app_id, events)
  local app, err = ks.getHashFields(app_id, external_routinginfo_schema)

  local headers = {
    ["Content-Type"] = "application/json"
  }
  if app.td.s then
    if app.td.t == "basic" then
      headers["Authorization"] = "Basic " .. h.getAppToken(app_id, app.td.s)
    elseif app.td.t == "token" then
      if app.td.tp and app.td.tp ~= ft.null then
        headers["Authorization"] = app.td.tp .. " " .. app.td.s
      else
        headers["Authorization"] = app.td.s
      end
    end
  end

  local result
  local status
  for _, event in ipairs(events) do
    result = Http.post({url = app.td.c, headers = headers, body = to_json(event)})
    status = result.status or result.status_code or 200

    if status >= 400 then
      break
    end
  end

  c.set("a_st_" .. app_id, status, 12 * 60 * 60) -- Keep last status code for 12 hour
  if result.error then
    c.set("a_err_" .. app_id, result.error, 24 * 60 * 60) -- Keep last error for 1 day
  end

  return result
end

local function validateMurano(id)
  if not id then
    return nil, e.get(400, "Missing required ID field")
  end
  local result = Interface.getSubscriber({subscriber_id = id})
  if result.error then
    if result.status == 404 then
      return nil, e.get('NOT_FOUND', "Application not linked")
    end
    return nil, e.get(500, "Unable to get subscriber")
  end
  return { id = id }
end

local function validateAndCleanExternal(data)
  -- In future add validation in sphinx-api, see internal_schema, same should apply on all apis
  if not data.td then
    return nil, e.get("WRONG_PARAMETERS", "Missing external app data")
  end
  if not data.td.c then
    return nil, e.get("WRONG_PARAMETERS", "Missing callback")
  end

  local cleaned_app = {
    n = data.name or data.n,
    d = data.description or data.d,
    u = data.url or data.u,
    l = data.logo or data.l,
    o = data.owner or data.o,
    td = {
      c = data.td.c,
      t = data.td.t,
      s = data.td.s or crypto.randomString(48),
      tp = data.td.tp
    }
  }
  if cleaned_app.n and string.len(cleaned_app.n) > 50 then
    return nil, e.get("WRONG_PARAMETERS", "App name should by less than 50 characters.")
  end

  return cleaned_app
end

local function connectMurano(data)
  return {app_id = data.id}
end

function a.connect(id)
  local t = a.getType(id)
  if t == types.MURANO then
    local d, err = validateMurano(id)
    if err then return nil, err end
    return connectMurano(d)
  elseif t == types.EXTERNAL_HTTPS then
    return nil, e.get(400, "Not supported yet")
  else
    return nil, e.get(400, "Invalid application type")
  end
end

function a.addExternal(data)
  local d, err = validateAndCleanExternal(data)
  if err then return nil, err end
  return a.createExternalApp(d)
end

function a.remove(app_id)
  local t = a.getType(app_id)
  if t == types.MURANO then
    return true -- Nothing special to be done for murano apps
  elseif t == types.EXTERNAL_HTTPS then
    ks.delHash(app_id)
  else
    return nil, e.get(400, "Invalid application type")
  end
end

function a.update(app_id, app)
  local t = a.getType(app_id)
  if t == types.MURANO then
    -- Nothing to edit yet for murano apps
    return true
  elseif t == types.EXTERNAL_HTTPS then
    return updateExternalApp(app_id, app)
  else
    return nil, e.get(400, "Invalid application type")
  end
end

return a
