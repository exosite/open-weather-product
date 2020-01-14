-- WARNING: Do not modify, changes will not persist updates
-- You can safely add new endpoints under /vendor/*

--#ENDPOINT GET /api/apps
local u = require("pdaas.users")
local d = require("pdaas.devices")
local r = require("pdaas.lib.router")

local listApps = function(user)
  local apps = u.listApps(user)
  for id, app in pairs(apps) do
    app.devices = 0
  end

  local counts = d.count(user.email)
  for id, count in pairs(counts) do
    if apps[id] then
      apps[id].devices = count
    end
  end
  return apps
end

r:start(request):run(u.verifyToken):run(listApps):response(response)

--#ENDPOINT POST /api/apps
local u = require("pdaas.users")
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")

local setup_app = function(user)
  local app = request.body
  app.o = user.email
  local data, err = a.addExternal(app)
  if err then
    return nil, err
  end
  local default = request.body.default
  local ok, err = u.addApp(user, data.app_id, default)
  if err then
    return nil, err
  end
  return data
end

r:start(request):run(u.verifyToken):run(setup_app):response(response)

--#ENDPOINT POST /api/apps/{id}
local u = require("pdaas.users")
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")

local setup_app = function(user)
  local id = request.parameters.id
  local valid, err = u.checkValidAppConnect(user, id)
  if err then
    return nil, err
  end
  local data, err = a.connect(id)
  if err then
    return nil, err
  end
  local default = request.body.default
  local ok, err = u.addApp(user, id, default)
  if err then
    return nil, err
  end
  return true
end

r:start(request):run(u.verifyToken):run(setup_app):response(response)

--#ENDPOINT PUT /api/apps/{id}
local u = require("pdaas.users")
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local e = require("pdaas.lib.errors")

local edit_app = function(user)
  local id = request.parameters.id
  local app = u.getApp(user, id)
  if not app then
    return nil, e.get(400, "No such app")
  end
  if not app.managed or app.owner == user.email then
    request.body.managed = nil
    local r, err = a.update(id, request.body)
    if err then return nil, err end
  end
  local default = request.body.default
  return u.updateApp(user, id, default)
end

r:start(request):run(u.verifyToken):run(edit_app):response(response)

--#ENDPOINT DELETE /api/apps/{id}
local u = require("pdaas.users")
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local e = require("pdaas.lib.errors")
local d = require("pdaas.devices")

local remove_app = function(user)
  local id = request.parameters.id
  local app = u.getApp(user, id)
  if not app then
    return nil, e.get(400, "No such app")
  end
  if app.managed then
    return nil, e.get(400, "Cannot delete managed app")
  end
  local r, err = d.removeFromDevices({name = "users", value = user.email}, {{name = "apps", value = id}})
  if err then
    return nil, err
  end
  local ok, err = a.remove(id)
  if err then
    return nil, err
  end
  local ok, err = u.removeApp(user, id)
  if err then
    return nil, err
  end
  return true
end

r:start(request):run(u.verifyToken):run(remove_app):response(response)
