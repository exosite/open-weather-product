local authentication = {}
-- This module authenticates the 3rd party cloud callback requests
-- To be updated depending on the security requirements

local cloudServiceName = require("c2c.murano2cloud").alias
local cache = require("c2c.vmcache")

function getToken ()
  local config = Config.getParameters({service = cloudServiceName})
  return config and config.callback_token
end

function getDomain ()
  local config = Config.getParameters({service = "webservice"})
  return config and config.domain
end

function authentication.getPeer(request)
  if request.parameters.token == cache("callback_token", getToken) then
    return "ok"
  end
end

function authentication.setToken(callback_token)
  -- If needed generate a token for connecting the 3rd party service to this solution
  callback_token = callback_token or mcrypto.b64url_encode(mcrypto.rand_bytes(20))

  -- Get Webservice domain parameters from configuration
  local callback_url = 'https://' .. cache("domain", getDomain) .. '/c2c/callback?token=' .. callback_token

  Config.setParameters({service = cloudServiceName, parameters = {
    -- to enable changing token from Murano UI
    callback_token = callback_token,
    -- so use can manually copy/past the callback url from Murano UI
    callback_url = callback_url
  }})
  return token
end

return authentication
