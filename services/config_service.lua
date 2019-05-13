function join(t1, t2)
  for _, v in pairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

function getType(definition)
  if definition:match("bool") ~= nil then
    return "BOOLEAN"
  elseif definition:match("char") ~= nil then
    return "STRING"
  end
  return "NUMBER"
end

if service.service == "sigfox" and (service.action == "added" or service.action == "updated") then
  local configIO = require("configIO")
  local currentTime = os.time(os.date("!*t"))
  local timestamp = currentTime * 1000000
  local isoTime = os.date("!%Y-%m-%dT%H:%M:%S.000Z", currentTime)
  local parameters = Config.getParameters({service = "sigfox"})
  local payloadConfigs = {}
  local channels = {}
  if parameters.parameters.callbacks ~= nil then
    for k, v in pairs(parameters.parameters.callbacks) do
      if v.payloadConfig ~= nil then
        join(payloadConfigs, v.payloadConfig)
      end
    end
  end
  for k, v in pairs(payloadConfigs) do
    local channelName, channel = configIO.createChannel(v.resource, v.definition)

    if channelName ~= "" then
      channels[channelName] = channel
    end
  end

  configIO.set({
    last_edited = isoTime,
    last_editor = "sigfox",
    channels = channels
  })

  -- When Sigfox service configuration changes fetch new data
  -- Eg. if password change or else..
  Sigfox.muranoSync()
  -- Would not be needed if Sigfox uses x-exosite-init/x-exosite-update lifecycle events
end