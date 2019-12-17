# OpenWeather Murano Connector

This project is Murano Connector template integrating the [OpenWeather API](https://openweathermap.org/) based on the
https://github.com/exosite/getting-started-solution-template/tree/cloud2cloud-product template.

Application adding this product can configure the list of zipcodes, GPS coordinates and cities to report their weather values.
Every hours the weather values are updated and reported to the application as devices would.

### Publish this template

- Make sure you have the OpenWeather Murano service available on Exosite Exchange.
- If not add it with the Swagger definition from ./openweatherapi.yaml
- Publish this template to Exosite Exchange IoT marketplace.

More info on http://docs.exosite.com/reference/ui/exchange/authoring-elements-guide/

### Using this template

1. Select this template and create a new IoT-Connector.
1. Go to the new IoT-Connector management page under `Services -> Openweatherapi` and enter your OpenWeatherMap credentials Key.

To set locations:

1. Navigate to the Connector management page under the `Devices` panel.
1. Create a new device and input the location as Identity.

You can provide the location as one of the following:
  - `<zip code>,<COUNTRY-CODE>` eg. `20455,TW`
  - `<longitude>,<latitude>` eg. `12.4,32.1`
  - `<City name>` eg. `Taipei`

Each configured locations will behave as a device emitting weather data every hours. You can force the update by going to the `Services -> Openweatherapi` and clicking `Apply` (no need of changing any value).
