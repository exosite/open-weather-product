-- This module handle 'configIO' metadata generation for Exosense applications
-- Define here the device data schema as describe in https://github.com/exosite/industrial_iot_schema
-- Limitation: Exosense currently cannot modify per device schema
--
-- This file is in the 'vendor' safeNamespace and changes will persists upon template updates

-- Schema defining the data passed from the `vendor.c2c.transform` module.
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
        "data_unit": "C"
      }
    },
    "temp_min": {
      "display_name": "Min Temperature",
      "description": "Minimum temperature or the day",
      "properties": {
        "data_type": "TEMPERATURE",
        "data_unit": "C"
      }
    },
    "temp_max": {
      "display_name": "Max Temperature",
      "description": "Maximum temperature of the day",
      "properties": {
        "data_type": "TEMPERATURE",
        "data_unit": "C"
      }
    },
    "wind_speed": {
      "display_name": "Wind Speed",
      "description": "Wind speed in meter/sec",
      "properties": {
        "data_type": "SPEED",
        "data_unit": "m/s"
      }
    },
    "wind_deg": {
      "display_name": "Wind Direction",
      "description": "Wind direction in Degrees",
      "properties": {
        "data_type": "ANGLE",
        "data_unit": "DEGREE"
      }
    },
    "clouds": {
      "display_name": "Clouds",
      "description": "Clouds coverage %",
      "properties": {
        "data_type": "PERCENTAGE",
        "data_unit": "%"
      }
    },
    "rain": {
      "display_name": "Rain",
      "description": "Rain volume for the last 1 hour, mm",
      "properties": {
        "data_type": "LENGTH",
        "data_unit": "mm"
      }
    },
    "snow": {
      "display_name": "Snow",
      "description": "Snow volume for the last 1 hour, mm",
      "properties": {
        "data_type": "LENGTH",
        "data_unit": "mm"
      }
    },
    "gps": {
      "display_name": "Location",
      "description": "Location",
      "properties": {
        "data_type": "LOCATION",
        "primitive_type": "JSON",
        "data_unit": "LAT_LONG"
      }
    }
  }
}
]]

return {
  timestamp = 1563939215, -- Unix timestamp of this schema version update
	config_io = config_io,
}
