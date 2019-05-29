
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

ExoSense application datamodel nest device data into the 'data_in' product resource of type JSON.
In order to be utilized from exosense the 'data' content have to be described in the 'config_io' resource.
This template automatically generates the 'config_io' from the Sigfox service callback payloadConfig settings.

As example a callback resources named "data_in.mydata" will be available to ExoSense using the base type inferred from the Sigfox decoding.

In order to utilize [ExoSense custom type](https://github.com/exosite/industrial_iot_schema/blob/master/data-types.md) the resources nested in 'data_in' needs to be named after the ExoSense type key.

Example: "data_in.temperature" will be of type 'TEMPERATURE'. Matching is case insensitive so "data_in.TEMPERATURE" will be the same.

You can also provides a matching unit types

Example: "data_in.temperature_deg_celsius" OR "data_in.temperature_C" will be of type 'TEMPERATURE' & unit 'DEG_CELSUIS'
