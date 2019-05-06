local configIO = {}

function configIO.get()
  local now = os.time(os.date("!*t"))
  if configIOCache == nil or now - configIOCache_ts > 10 then
    local result = Keystore.get({ key = "config_io" })
    if result ~= nil and result.value ~= nil then
      -- Following is a VM global value cached on hot VM
      configIOCache, err = json.parse(result.value)
      if err ~= nil then
        print("The config_io parse error", err)
      else
        configIOCache_ts = now
      end
    end
  end
  local configIOString, err = json.stringify(configIOCache.config)
  if err ~= nil then
    print("The config_io encode to JSON error", err)
    return { config = "" }
  else
    return { timestamp = configIOCache.timestamp, config = configIOString }
  end
end

function configIO.set(configIO)
  local timestamp = os.time(os.date("!*t"))
  local configIOTable = { timestamp = timestamp * 1000000, config = configIO }
  local configIOString, err = json.stringify(configIOTable)
  if err ~= nil then
    print("The config_io encode to JSON error", err)
  else
    configIOCache = configIOTable
    configIOCache_ts = timestamp
    Keystore.set({ key = "config_io", value = configIOString })
  end
end

function configIO.createChannel(resource, definition)
  local channelName = ""
  local properties = {}
  local channelName, nestJson = string.match(resource, "data_in%.(%w+)%.?(.*)")
  if channelName == "gps" and nestJson == "lng" or nestJson == "lat" then
    properties.data_type = "LOCATION"
    properties.data_unit = "LAT_LONG_ALT"
  elseif nestJson ~= nil then
    properties.data_type = "JSON"
  elseif channelName then
    properties.data_type = getType(definition)
  end

  if channelName ~= "" then
    return channelName, {
      display_name = channelName,
      description = "",
      properties = properties
    }
  else
    return channelName, {}
  end
end

return configIO