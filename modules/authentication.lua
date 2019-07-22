local authentication = {}
-- This module authenticates the 3rd party cloud callback requests
-- To be updated depending on the security requirements

local cloudServiceName = require("murano2cloud").alias

function authentication.getPeer(request)
  if request.parameters.token == Keystore.get({key = "callback_token"}) then
    return "ok"
  end
end

function authentication.setToken(token)
  -- If needed generate a token for connecting the 3rd party service to this solution
  token = token or mcrypto.b64url_encode(mcrypto.rand_bytes(20))

  -- Save the token to validate callbacks in 'authentication' module
  Keystore.set({key = "callback_token", value = token})

  -- Get Webservice domain parameters from configuration
  local params = Config.getParameters({service="webservice"})
  local callback_url = 'https://' .. params.domain .. '/api/callback?token=' .. token

  Config.setParameters({service = cloudServiceName, parameters = {
    -- to enable changing token from Murano UI
    callback_token = token,
    -- so use can manually copy/past the callback url from Murano UI
    callback_url = callback_url
  }})
  return token
end

return authentication
