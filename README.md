
# Sigfox Murano Product

This project is Sigfox integration for Murano Products. It is compatible with any Murano applications including ExoSense.

### Setup

- Purchase this template from [Murano Exchange IoT marketplace](https://www.exosite.io/business/<business>/exchange/catalog).
- On [Murano -> Solutions](https://www.exosite.io/business/<business>/solutions): Create a product by selecting this template
- On [Murano -> Sigfox Product -> services -> Sigfox](https://www.exosite.io/business/<business>/connectivity/<product>/services): Input your Sigfox account credentials and the callbacks setting
- Go the the webpage [<product id>.apps.exosite.io](https://<product>.apps.exosite.io)
- Hit 'Try' button
- All set

### Additional setup for ExoSense

- The callback payloadConfig requires to set channels data nested in the 'data_in' resource.
- Example: "data_in.temperature"
- Then go on ExoSense user interface and add the new channels matching the above settings. (eg. temperature)
