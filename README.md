
# Sigfox Murano Product

This project is a [Sigfox](https://www.sigfox.com) integration for Murano Products. It is compatible with any Murano applications including ExoSense.

### Setup

- First you will need a [Sigfox backend account](https://backend.sigfox.com) ready for your devices connectivity.
- Navigate to [Murano Exchange IoT marketplace](https://www.exosite.io/business/<business>/exchange/catalog)
- In the 'Service' section add the 'Sigfox' service.
- In the 'Solution Template' section add the 'Sigfox Product' template.
- Then create your product solution using the 'Sigfox Product' template.
- Go to the product configuration on [Murano -> Sigfox Product -> services -> Sigfox](https://www.exosite.io/business/<business>/connectivity/<product>/services)
- Input your Sigfox API credentials generated from your [Sigfox backend account](https://backend.sigfox.com)
- Add one (or more) callbacks matching your [Sigfox deviceType Id](https://backend.sigfox.com/devicetype/list)
- Finally add the 12bytes resource mapping using the [Sigfox decoding grammar](http://docs.exosite.com/quickstarts/sigfox/decoding-grammar/)
- All set, any device reporting to your [Sigfox deviceType Id](https://backend.sigfox.com/devicetype/list) will be provisionned automatically in your Murano Product.

Find More information on http://docs.exosite.com/quickstarts/sigfox/

### Additional setup for ExoSense

- The callback payloadConfig requires to set channels data nested in the 'data_in' resource.
- Example: "data_in.temperature"
- Then go on ExoSense user interface and add the new channels matching the above settings. (eg. temperature)
