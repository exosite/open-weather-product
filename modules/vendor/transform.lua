-- This file enable device data transformation for the template user
--
-- This file is in the 'vendor' safeNamespace and changes will persists upon template updates

local transform = {}

function transform.data_in(cloud_data)
  -- Transform data from the 3rd party service to Murano
  return cloud_data
end

function transform.data_out(murano_data)
  -- Transform data from Murano to the 3rd party service
  return murano_data
end

return transform
