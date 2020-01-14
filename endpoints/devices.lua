-- WARNING: Do not modify, changes will not persist updates
-- You can safely add new endpoints under /vendor/*

--#ENDPOINT POST /api/claim
--#SECURITY none
local u = require("pdaas.users")
local t = require("pdaas.lib.tokens")
local d = require("pdaas.devices")
local r = require("pdaas.lib.router")
local e = require("pdaas.lib.errors")

local function claimAuthCheck(request)
  local user = u.verifyToken(request)
  local context = nil
  local app_id = nil
  if request.headers.session ~= nil then
    local session = request.headers.session
    local verified = t.verifyToken(session, t.token_permissions.CLAIM_DEVICES_ONLY)
    if verified then
      app_id = verified.a
      context = verified.c
    end
  elseif user then
    local default = request.body.default or false
    if default then
      local default_apps, err = u.listApps(user, default)
      if err then return nil, err end
      app_id = {}
      for id, app in pairs(default_apps) do
        if app.default then
          table.insert(app_id, id)
        end
      end
    end
  end
  if user or app_id then
    return {user = user.email, app_id = app_id, context = context, code = request.body.code}
  end
  return nil, e.NOT_AUTHORIZED
end

r:start(request):run(claimAuthCheck):run(
  function(r)
    return d.claimDevices(r.code, r.user, r.app_id, r.context)
  end
):response(response)

--#ENDPOINT GET /api/devices
local u = require("pdaas.users")
local r = require("pdaas.lib.router")
local e = require("pdaas.lib.errors")

local function listDevices(user)
  local app_id = request.parameters.app
  if app_id and app_id ~= "" then
    local hasapp = u.hasApp(user, app_id)
    if not hasapp then
      return nil, e.NOT_AUTHORIZED
    end
  end
  return u.listDevices(user, app_id)
end
r:start(request):run(u.verifyToken):run(listDevices):response(response)

--#ENDPOINT DELETE /api/devices/{identity}
local u = require("pdaas.users")
local r = require("pdaas.lib.router")
local d = require("pdaas.devices")
local i = require("pdaas.interface")
local e = require("pdaas.lib.errors")

local function resetDevice(user)
  local identity = request.parameters.identity
  local device = i.isOwnerOf(nil, user.email, identity)
  if device ~= nil then
    d.resetDevice(identity)
    return true
  end
  return nil, e.NOT_AUTHORIZED
end

r:start(request):run(u.verifyToken):run(resetDevice):response(response)


--#ENDPOINT POST /api/devices
local u = require("pdaas.users")
local r = require("pdaas.lib.router")
local d = require("pdaas.devices")
local i = require("pdaas.interface")
local e = require("pdaas.lib.errors")
local devices = request.body.devices or {}
local add_apps = request.body.add_apps or {}
local remove_apps = request.body.remove_apps or {}

local function editDevices(user)
  local apps, error = u.listApps(user, true)
  if error then
    return nil, error
  end
  local filtered_add_apps = {}
  local filtered_remove_apps = {}
  for _, app_id in ipairs(add_apps) do
    local exists = apps[app_id]
    if exists then
      table.insert(filtered_add_apps, app_id)
    end
  end
  for _, app_id in ipairs(remove_apps) do
    local exists = apps[app_id]
    if exists then
      table.insert(filtered_remove_apps, app_id)
    end
  end
  for _, identity in ipairs(devices) do
    local device = i.isOwnerOf(nil, user.email, identity)
    if device ~= nil then
      d.addApps(identity, filtered_add_apps)
      d.removeApps(identity, filtered_remove_apps)
    end
  end
end

r:start(request):run(u.verifyToken):run(editDevices):response(response)
