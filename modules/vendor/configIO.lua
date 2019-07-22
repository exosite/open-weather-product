-- Define here the device data schema as describe in https://github.com/exosite/industrial_iot_schema
-- This module handle 'configIO' metadata generation for Exosense applications
-- Exosense expects each device to have its own data structure.
-- However in most Could2Cloud cases a single structure applies to all devices
-- This files store a single structure in the Keystore service and inject it when needed
-- and cache it to the hot lua VM for efficiency.
--
-- This file is in the 'vendor' safeNamespace and changes will persists upon template updates


local config_IO = from_json([[
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
]])

return {
	config_io = config_io,
	timestamp = os.time(os.date("!*t"))
}
