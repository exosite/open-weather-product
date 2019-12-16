local murano2cloud = {}
-- This module maps local changes and propagate them to the 3rd party cloud
-- The operation must follow the 3rd party service swagger definition you published from ../openweatherapi.yaml

murano2cloud.alias = "openweatherapi"

function murano2cloud.addIdentity(identity)
end

function murano2cloud.removeIdentity(identity)
end

function murano2cloud.setIdentityState(identity, data)
end

-- Function for recurrent poll action
function murano2cloud.sync(query)
  local result = murano.services[murano2cloud.alias].getWeather({
    q = query
  })
  if result.error then
    log.error(result.error)
  else
    return result
  end
end

return murano2cloud
