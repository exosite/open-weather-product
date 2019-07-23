-- This module handle 'configIO' metadata generation for Exosense applications
-- Define here the device data schema as describe in https://github.com/exosite/industrial_iot_schema
-- Limitation: Exosense currently cannot modify per device schema
--
-- This file is in the 'vendor' safeNamespace and changes will persists upon template updates


local config_io = [[
 {
  "channels": {
    "005": {
      "display_name": "Machine Status",
      "description": "Device reported status",
      "properties": {
        "data_type": "STRING",
        "primitive_type": "STRING"
      }
    }
  }
}
]]

return {
  timestamp = 1563939215, -- Unix timestamp of this schema version update
	config_io = config_io,
}
