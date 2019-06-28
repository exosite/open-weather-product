
local transform = require("transform")
if event.payload ~= nil and transform ~= nil and transform.convertIdentityState ~= nil then
  for i, data in ipairs(event.payload) do
    if data.values ~= nil and data.values.data_in ~= nil then
      event.payload[i].values = transform.convertIdentityState(data.values)
    end
  end
end

return Interface.trigger({event="event", data=event})
