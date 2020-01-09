
-- This part is needed as Timer init event is missing
-- This can be removed once MUR-10927 is released
Config.setParameters({ service = "timer", parameters = { } }) -- Force apply init configuration
