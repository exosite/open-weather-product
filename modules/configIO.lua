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
  if configIOCache == nil then
    return { config = "" }
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

function getPrimitivType(definition, nestJson)
  if nestJson and nestJson ~= "" then
    return "JSON"
  elseif definition:match("bool") ~= nil then
    return "BOOLEAN"
  elseif definition:match("char") ~= nil then
    return "STRING"
  end
  return "NUMBER"
end

function configIO.createChannel(resource, definition)
  local channelTypes = require("channelTypes")
  local channelName, nestJson = string.match(resource, "data_in%.([%w_]+)%.?(.*)")
  local displayName = ""
  local description = ""
  local properties = {
    data_type = getPrimitivType(definition, nestJson)
  }

  -- Hard-coded custom mapping
  if channelName == "gps" and nestJson == "lng" or nestJson == "lat" then
    properties.data_type = "LOCATION"
    properties.data_unit = "LAT_LONG_ALT"
  elseif channelName then
    local tLen, lLen
    -- getting type from matching resource name to Exosense type
    for i, type in ipairs(channelTypes) do
      tLen = string.len(type.id)
      if string.upper(string.sub(channelName, 1, tLen)) == type.id
        -- primitive_type is not yet in the types files but should be
        -- and properties.data_type == type.primitive_type
      then
        properties.data_type = type.id
        if type.name then
          displayName = type.name
          description = type.name
        end

        -- getting unit
        if type.units then
          for i, unit in ipairs(type.units) do
            lLen = 0
            if string.upper(string.sub(channelName, tLen + 2, tLen + 1 + string.len(unit.id))) == unit.id then
              lLen = string.len(unit.id)
            else
              local abbr = string.upper(string.gsub(unit.abbr, "([^%w])", ""))
              if string.upper(string.sub(channelName, tLen + 2, tLen + 1 + string.len(abbr))) == abbr then
                lLen = string.len(abbr)
              end
            end
            if lLen > 0 then
              properties.data_unit = unit.id
              if unit.name then
                displayName = displayName .. ' (' .. (unit.abbr or unit.name) .. ')'
                description = description .. ' in ' .. unit.name
              end
              break
            end
          end
        end
        break
      end
    end
  end

  if not channelName then
    return nil
  end

  if displayName == "" then
    displayName = channelName
  end
  if description == "" then
    description = displayName
  end

  return channelName, {
    display_name = displayName,
    description = description,
    properties = properties
  }
end

return configIO
