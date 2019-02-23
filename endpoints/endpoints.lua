--#ENDPOINT POST /callback/{apiUser}/{deviceTypeId}/{payloadConfig}

if request.body == nil or request.body == "" or request.body == {} then
  response.code = 400
  return "Missing product resources definition in body content. Eg. {temp = \"{customData#temp}\"}"
end

if request.parameters.apiUser == nil or request.parameters.apiUser == "" then
  response.code = 400
  return "Missing apiUser parameter matching the Sigfox service configuration on Murano UI"
end

if request.parameters.deviceTypeId == nil or request.parameters.deviceTypeId == "" then
  response.code = 400
  return "Missing deviceTypeId parameter matching Sigfox portal setup"
end

if request.parameters.payloadConfig == nil or request.parameters.payloadConfig == "" then
  response.code = 400
  return "Missing payloadConfig parameter allowing to parse Sigfox 12 bytes data"
end

return Sigfox.createCallback({
  productId = context.solution_id,
  apiUser = request.parameters.apiUser,
  deviceTypeId = request.parameters.deviceTypeId,
  payloadConfig = request.parameters.payloadConfig, -- eg "temperature::uint:8 humidity::uint:8 alarm::bool:7",
  productResources = request.body -- Incoming data mapping to device2 resources
  -- eg:
  -- {
  --   data_in = {
  --     temperature = "{customData#temperature}"
  --   },
  --   alarm = "{customData#alarm}"
  -- }

  -- This part is duplicated we could have it all setup in payloadConfig string as
  -- "data_in_obj.temperature::uint:8 humidity::uint:8 alarm::bool:7",
  -- or better in an array so it can get setup easilly by apps
  -- [{
  --   resource: "data_in_obj.temperature",
  --   type: "uint", -- Or conbine size with type
  --   size: 8
  --  }, { ..
  -- }]
})

--#ENDPOINT DELETE /callback/{apiUser}/{deviceTypeId}

if request.parameters.apiUser == nil or request.parameters.apiUser == "" then
  response.code = 400
  return "Missing apiUser parameter matching the Sigfox service configuration on Murano UI"
end

if request.parameters.deviceTypeId == nil or request.parameters.deviceTypeId == "" then
  response.code = 400
  return "Missing deviceTypeId parameter matching Sigfox portal setup"
end

return Sigfox.removeCallback({
  apiUser = request.parameters.apiUser,
  deviceTypeId = request.parameters.deviceTypeId,
})
