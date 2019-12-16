-- This file enable device data transformation for the template user
--
-- This file is in the 'vendor' safeNamespace and changes will persists upon template updates

local transform = {}

function transform.data_in(cloud_data)
  -- Transform data from the 3rd party service to Murano to be saved in the `data_in` resource.
  -- Find the details of OpenWeatherMap data in https://openweathermap.org/current

  -- NOTE: if you change this file you should reflect the structure to the `vendor.configIO` module.
  local data = cloud_data.main
  if data.wind then
    data.wind_speed = cloud_data.wind.speed
    data.wind_deg = cloud_data.wind.deg
  end
  if data.coord then
    data.gps = {
      lat = data.coord.lat,
      lng = data.coord.lon -- match Exosense Format
    }
  end
  if data.clouds then
    data.clouds = cloud_data.clouds.all
  end
  if data.rain then
    data.rain = cloud_data.rain["1h"]
  end
  if data.snow then
    data.show = cloud_data.show["1h"]
  end
  return data
end

return transform
