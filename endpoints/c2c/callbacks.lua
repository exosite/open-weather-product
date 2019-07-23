-- Configure here the callbacks logic from the remote cloud.
-- Set the authentication logic in the authentication module.

--#ENDPOINT POST /c2c/callback
-- A generic handler for device information changes
local peer = require('authentication').getPeer(request)

if peer == nil then
  response.code(401)
  return ""
end

local options = {
  ip = request.headers["x-forwarded-for"],
  timestamp = request.body.timestamp or request.timestamp,
  request_id = request.request_id
}

require("c2c.cloud2murano").sync(request.body, options)
