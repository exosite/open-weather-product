-- This file enable device data transformation for the template user
--
-- This file is in the 'vendor' safeNamespace and changes will persists upon template updates

local transform = {}

function transform.data_in(cloud_data)
  -- Transform data from the 3rd party service to Murano to be saved in the `data_in` resource.
  -- Find the details of OpenWeatherMap data in https://openweathermap.org/current

  -- NOTE: if you change this file you should reflect the structure to the `vendor.configIO` module.
  local data_in = cloud_data.main
  if cloud_data.wind then
    data_in.wind_speed = cloud_data.wind.speed
    data_in.wind_deg = cloud_data.wind.deg
  end
  if cloud_data.coord then
    data_in.gps = {
      lat = cloud_data.coord.lat,
      lng = cloud_data.coord.lon -- match Exosense Format
    }
  end
  if cloud_data.clouds then
    data_in.clouds = cloud_data.clouds.all
  end
  if cloud_data.rain then
    data_in.rain = cloud_data.rain["1h"]
  end
  if cloud_data.snow then
    data_in.show = cloud_data.show["1h"]
  end
  -- Here we comply to ExoSense data structure
  return { data_in = data_in }
  -- For ExoHome or other app use:
  -- return data_in
end

return transform
