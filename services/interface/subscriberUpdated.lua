-- Subscriber was added get his settings.

local cities = subscription.parameters.cities
if not cities then
  return
end

for i, city in pairs(cities) do
  Device2.addIdentity({ identity = city })
end

require("c2c.cloud2murano").syncAll()
