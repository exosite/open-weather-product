
# OpenWeather Murano Product

This project is simplistic Murano Product template integrating to the OpenWeather API based on the
https://github.com/exosite/getting-started-solution-template/tree/cloud2cloud-product template.

Application adding this product can configure the list of cities to report their weather values.
Every hours the weather values are updated and reported to the application as devices would.

### Publish this template

- Make sure you have the OpenWeather Murano service available on Exosite Exchange.
- If not add it with the Swagger definition from ./openweatherapi.yaml
- Publish this template to Exosite Exchange IoT marketplace.

More info on http://docs.exosite.com/reference/ui/exchange/authoring-elements-guide/

### Using this template

- On Exosite Iot Marketplace select this template and create a product solution.
- Go to the new product management under Services->OpenWeather and enter your credentials.
- Go to your application solution page under Services->Product Setup & 'Add product'
- Select the newly created product & apply
- Go to the product configuration tab and add the city you with to get weather from.
- You should get the weather
