-- WARNING: Do not modify, changes will not persist updates

local u = {}

local a = require("pdaas.apps")
local t = require("vendor.template")
local e = require("pdaas.lib.errors")
local h = require("pdaas.lib.helper")
local to = require("pdaas.lib.tokens")
if global_domain == nil then
  local webservice = Config.getParameters({service = "webservice"})
  global_domain = webservice.parameters.domain -- global cached by hotvm
end

function u.signup (email)
  local token = to.createAuthToken("", to.token_permissions.USER_CREATION_TOKEN, email, 120)
  local html =
    t.get(
    "signup",
    {
      domain = global_domain,
      token = token
      -- @TODO load brandingJson and add to template context
    }
  )
  -- @TODO load brandingJSON and add the 'from' email
  local emailData = {
    to = {
      email
    },
    subject = "IoT Connector Account Activation",
    html = html
  }
  local res = Email.send(emailData)
  if res.error then
    return nil, e.get("WRONG_PARAMETERS", "Unable to send validation Email")
  end
end

function u.find(email)
  local query = {
    ["filter"] = {"email::like::" .. email},
    ["limit"] = 1
  }
  local result = User.listUsers(query)
  if not result or not result.items or not result.items[1] then
    return nil, e.NOT_FOUND
  end
  return result.items[1]
end

-- Force the user creation to get the user Id before activation
function getOrCreate(email)
  local user, error = u.find(email)

  if user then
    return user
  end
  if error then
    return nil, error
  end

  local code, error = User.createUser(
    {
      name = string.match(email, "^[^@]+"),
      password = 'password',
      email = email
    }
  )
  if error then
    return nil, error
  end
  code, error = User.activateUser({code = code})
  if error then
    return nil, error
  end
  -- Reset password for user to define a new password
  u.signup(email)
  return u.find(email)
end


local function starts_with(str, start)
  return str:sub(1, #start) == start
end

function u.listApps(user, light)
  local parameters = {
    ["id"] = user.id
  }
  local response = User.listUserData(parameters)
  if response.error then
    return nil, e.get(500, response.error)
  end
  local apps = {}
  for key, v in pairs(response) do
    if starts_with(key, "app_") then
      local id = key:sub(5)
      local info = a.info(id)
      if not light then
        info = a.info(id)
      end
      if v == "default" then
        info.default = true
      else
        info.default = false
      end
      apps[id] = info
    end
  end

  local managedApps = os.getenv("managedApps")
  if managedApps and string.len(managedApps) > 1 then
    for id in string.gmatch(managedApps, '([^,]+)') do
      if apps[id] then
        apps[id].managed = true
      elseif light then
        apps[id] = {
          managed = true
        }
      else
        local info = a.info(id)
        if info then
          info.managed = true
          if info.o ~= user.email then
            info.td = nil
          end
          apps[id] = info
        end
      end
    end
  end
  return apps
end

function u.listDevices(user, app_id)
  local query = {limit = 5000}
  query.tag = {name = "users", value = user.email}
  local res = Device2.listIdentities(query)
  if res.error then
    return nil, error
  end
  local result = {}
  for _, device in ipairs(res.devices) do
    local toadd = false
    for _, tag in ipairs(device.tags or {}) do
      if app_id and app_id ~= "" then
        if tag.name == "apps" and tag.value == app_id then
          toadd = true
        end
      else
        toadd = true
      end
      if tag.name == "apps" or tag.name == "users" then
        device[tag.name] = device[tag.name] or {}
        table.insert(device[tag.name], tag.value)
      end
    end
    device.tags = nil
    if toadd then
      result[#result + 1] = device
    end
  end
  return result
end

function u.hasApp(user, app_id)
  local apps, error = u.listApps(user, true)
  if error then
    return nil, error
  end
  local exists = apps[app_id]
  if exists then
    return true
  else
    return false
  end
end

function u.getApp(user, app_id)
  local apps, error = u.listApps(user)
  if error then
    return nil, error
  end
  return apps[app_id]
end

local max_apps = 10
-- Check if app already exists or there are too many apps
function u.checkValidAppConnect(user, app_id)
  local apps, err = u.listApps(user, true)
  if err then
    return error
  end
  local count = 0
  for _ in pairs(apps) do
    count = count + 1
  end
  if count >= max_apps then
    return nil, e.get('WRONG_PARAMETERS', "Already at max apps: " .. tostring(max_apps))
  end
  if app_id then
    local exists = apps[app_id]
    if exists then
      return nil, e.get('DUPLICATED', "Application id already exists")
    end
  end
  return true
end

function u.addApp(user, app_id, default)
  local v = "default"
  if not default then v = "" end
  local parameters = {
    ["id"] = user.id,
    ["app_" .. app_id] = v
  }
  local response = User.createUserData(parameters)
  if response.error then
    return nil, e.get(500, response.error)
  end

  return true
end

function u.updateApp(user, app_id, default)
  local v = "default"
  if not default then v = "" end
  local parameters = {
    ["id"] = user.id,
    ["app_" .. app_id] = v
  }
  local response = User.updateUserData(parameters)
  if response.status == 400 then
    response = User.createUserData(parameters)
  end
  if response.error then
    return nil, e.get(500, response.error)
  end

  return true
end

function u.removeApp(user, app_id)
  local parameters = {
    id = user.id,
    keys = { "app_" .. app_id }
  }
  local response = User.deleteUserData(parameters)
  if response.error and response.status ~= 400 and response.status ~= 404 then
    return nil, e.get(500, "Unable to remove userdata")
  end
  return true
end

function u.verifyToken(request)
  local authorization = request.headers.authorization
  if not authorization then
    return nil, e.NOT_AUTHENTICATED
  end
  local user =
    User.getCurrentUser(
    {
      token = authorization
    }
  )
  if not user or user.error then
    return nil, e.NOT_AUTHENTICATED
  end
  return user
end

return u
