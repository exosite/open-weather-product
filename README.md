
# OpenWeather Murano Connector

This project is Murano Connector template integrating the [OpenWeather API](https://openweathermap.org/) based on the
https://github.com/exosite/getting-started-solution-template/tree/cloud2cloud-product template.

Application adding this product can configure the list of cities to report their weather values.
Every hours the weather values are updated and reported to the application as devices would.

### Publish this template

- Make sure you have the OpenWeather Murano service available on Exosite Exchange.
- If not add it with the Swagger definition from ./openweatherapi.yaml
- Publish this template to Exosite Exchange IoT marketplace.

More info on http://docs.exosite.com/reference/ui/exchange/authoring-elements-guide/

### Using this template

1. Select this template and create an IoT-Connector solution.
1. Go to the new IoT-Connector management page under `Services->OpenWeather` and enter your OpenWeather credentials.
1. Add the new IoT-Connector and add it to you application
1. Go to your application solution page under Services->Product Setup
1. Select the newly created Connector and add the city you with to get weather from.
1. You should get the weather as data coming from a Device named after the specified city
