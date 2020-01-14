
-- This part is needed as Timer init event is missing
-- This can be removed once MUR-10927 is released
Config.setParameters({ service = "timer", parameters = { } }) -- Force apply init configuration
local i = require("pdaas.interface")
local m = require("pdaas.lib.migrations")
local version, error = m.run()
if error ~= nil then
  log.error("Migration failed with: " .. error)
else
  log.warn("Migration succeeded, current version: " .. tostring(version))
end
i.updateDescription()
