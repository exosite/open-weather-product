
local transform = require("transform")
if event.payload ~= nil and transform ~= nil and transform.convertIdentityState ~= nil then
  event.payload = transform.convertIdentityState(event.payload)
end

return Interface.trigger({event="event", data=event})
