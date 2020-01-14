-- WARNING: Do not modify, changes will not persist updates
-- You can safely add new endpoints under /vendor/*

--#ENDPOINT POST /api/users/login
--#SECURITY none
local e = require("pdaas.lib.errors")
local r = require("pdaas.lib.router")
local email = string.lower(request.body.email)
local password = request.body.password

r:start(request):run(
  function(r)
    if password then
      return r
    else
      return nil, e.get("WRONG_PARAMETERS", "Missing password")
    end
  end
):run(
  function(r)
    local token =
      User.getUserToken(
      {
        email = email,
        password = password,
        time_to_live = 24 * 60 * 60
      }
    )
    if not token or type(token) ~= "string" then
      return nil, e.NOT_AUTHENTICATED
    end
    return token
  end
):response(response)

--#ENDPOINT POST /api/users/create
--#SECURITY none
local u = require("pdaas.users")
local r = require("pdaas.lib.router")

r:start(request):run(
  function(r)
    return u.signup(string.lower(request.body.email))
  end
):response(response)

--#ENDPOINT POST /api/users/activate
--#SECURITY none
local u = require("pdaas.users")
local r = require("pdaas.lib.router")
local e = require("pdaas.lib.errors")
local to = require("pdaas.lib.tokens")
local code = request.body.code
local password = request.body.password

r:start(request):run(
  function(r)
    if password and code then
      return r
    else
      return nil, e.get("WRONG_PARAMETERS", "Missing password or code")
    end
  end
):run(
  function(r)
    return to.verifyToken(code, to.token_permissions.USER_CREATION_TOKEN, "")
  end
):run(
  function(info)
    local newuser = true
    local email = info.c
    local response =
      User.createUser(
      {
        name = string.match(email, "^[^@]+"),
        password = password,
        email = email
      }
    )
    if not response or response.error then
      return nil, e.INTERNAL
    elseif response.status == 400 then
      local query = {
        ["filter"] = {"email::like::" .. email},
        ["limit"] = 1
      }
      local result = User.listUsers(query)
      if not result or not result.items or not result.items[1] then
        return nil, e.NOT_FOUND
      end
      User.resetUserPassword({id = result.items[1].id, password = password})
      to.deleteToken(code)
      newuser = false
    else
      User.activateUser({code = response})
      to.deleteToken(code)
    end

    local token =
      User.getUserToken(
      {
        email = email,
        password = password,
        time_to_live = 24 * 60 * 60
      }
    )

    if newuser then
      local user =
        User.getCurrentUser(
        {
          token = token
        }
      )
    end

    return token
  end
):response(response)

--#ENDPOINT GET /api/users/currentUser
local r = require("pdaas.lib.router")
local u = require("pdaas.users")

r:start(request):run(u.verifyToken):response(response)
