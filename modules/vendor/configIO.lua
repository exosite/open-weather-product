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
      "description": "Humidity (%)",
      "properties": {
        "data_type": "HUMIDITY",
        "data_unit": "PERCENT"
      }
    },
    "pressure": {
      "display_name": "Pressure",
      "description": "Pressure (atm)",
      "properties": {
        "data_type": "PRESSURE",
        "data_unit": "ATMOSPHERE"
      }
    },
    "temp": {
      "display_name": "Temperature",
      "description": "Temperature (ºC)",
      "properties": {
        "data_type": "TEMPERATURE",
        "data_unit": "DEG_CELSIUS"
      }
    },
    "temp_min": {
      "display_name": "Low Temperature",
      "description": "Minimum temperature (ºC) or the day",
      "properties": {
        "data_type": "TEMPERATURE",
        "data_unit": "DEG_CELSIUS"
      }
    },
    "temp_max": {
      "display_name": "High Temperature",
      "description": "Maximum temperature (ºC) of the day",
      "properties": {
        "data_type": "TEMPERATURE",
        "data_unit": "DEG_CELSIUS"
      }
    },
    "wind_speed": {
      "display_name": "Wind Speed",
      "description": "Wind speed (m/s)",
      "properties": {
        "data_type": "SPEED",
        "data_unit": "METER_PER_SEC"
      }
    },
    "wind_deg": {
      "display_name": "Wind Direction",
      "description": "Wind direction (º)",
      "properties": {
        "data_type": "ANGLE",
        "data_unit": "DEGREE"
      }
    },
    "clouds": {
      "display_name": "Cloud Coverage",
      "description": "Cloud coverage (%)",
      "properties": {
        "data_type": "PERCENTAGE",
        "data_unit": "PERCENT"
      }
    },
    "rain": {
      "display_name": "Rain",
      "description": "Rain volume (mm) over past 1 hour",
      "properties": {
        "data_type": "LENGTH",
        "data_unit": "MILLIMETERS"
      }
    },
    "snow": {
      "display_name": "Snow",
      "description": "Snow volume (mm) over past 1 hour",
      "properties": {
        "data_type": "LENGTH",
        "data_unit": "MILLIMETERS"
      }
    },
    "gps": {
      "display_name": "Location",
      "description": "Location",
      "properties": {
        "data_type": "LOCATION",
        "data_unit": "LAT_LONG"
      }
    }
  }
}
]]

return {
  timestamp = 1733870997, -- Unix timestamp of this schema version update
	config_io = config_io,
}
