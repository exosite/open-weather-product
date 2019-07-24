-- This module handle 'configIO' metadata generation for Exosense applications
-- Define here the device data schema as describe in https://github.com/exosite/industrial_iot_schema
-- Limitation: Exosense currently cannot modify per device schema
--
-- This file is in the 'vendor' safeNamespace and changes will persists upon template updates

local config_io = [[
 {
  "channels": {
    "humidity": {
      "display_name": "Humidity",
      "description": "Humidity",
      "properties": {
        "data_type": "HUMIDITY",
        "data_unit": "PERCENT"
      }
    },
    "pressure": {
      "display_name": "Pressure",
      "description": "Pressure",
      "properties": {
        "data_type": "PRESSURE",
        "data_unit": "ATMOSPHERE"
      }
    },
    "temp": {
      "display_name": "Temperature",
      "description": "Temperature",
      "properties": {
        "data_type": "TEMPERATURE",
        "data_unit": "K"
      }
    }
  }
}
]]

return {
  timestamp = 1563939215, -- Unix timestamp of this schema version update
	config_io = config_io,
}
