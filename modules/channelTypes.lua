local types = [[
[
	{
		"name": "Custom",
		"id": "CUSTOM"
	},
	{
		"name": "Boolean",
		"id": "BOOLEAN"
	},
	{
		"name": "String",
		"id": "STRING"
	},
	{
		"name": "JSON",
		"id": "JSON"
	},
	{
		"name": "Length",
		"id": "LENGTH",
		"convertable": true,
		"units": [
			{
				"name": "meters",
				"id": "METERS",
				"convert": "m",
				"abbr": "m"
			},
			{
				"name": "centimeters",
				"id": "CENTIMETERS",
				"convert": "cm",
				"abbr": "cm"
			},
			{
				"name": "micrometers",
				"id": "MICROMETERS",
				"convert": "um",
				"abbr": "μm"
			},
			{
				"name": "kilometers",
				"id": "KILOMETERS",
				"convert": "km",
				"abbr": "km"
			},
			{
				"name": "millimeters",
				"id": "MILLIMETERS",
				"convert": "mm",
				"abbr": "mm"
			},
			{
				"name": "feet",
				"id": "FEET",
				"convert": "ft",
				"abbr": "ft"
			},
			{
				"name": "inch",
				"id": "INCH",
				"convert": "in",
				"abbr": "in"
			},
			{
				"name": "yard",
				"id": "YARD",
				"convert": "yd",
				"abbr": "yd"
			},
			{
				"name": "miles",
				"id": "MILES",
				"convert": "mi",
				"abbr": "mi"
			},
			{
				"name": "microns",
				"id": "MICRONS",
				"abbr": "μ",
				"convert": "um"
			}
		]
	},
	{
		"name": "Displacement",
		"id": "DISPLACEMENT",
		"convertable": true,
		"units": [
			{
				"name": "meters",
				"id": "METERS",
				"convert": "m",
				"abbr": "m"
			},
			{
				"name": "centimeters",
				"id": "CENTIMETERS",
				"convert": "cm",
				"abbr": "cm"
			},
			{
				"name": "micrometers",
				"id": "MICROMETERS",
				"convert": "um",
				"abbr": "μm"
			},
			{
				"name": "kilometers",
				"id": "KILOMETERS",
				"convert": "km",
				"abbr": "km"
			},
			{
				"name": "millimeters",
				"id": "MILLIMETERS",
				"convert": "mm",
				"abbr": "mm"
			},
			{
				"name": "feet",
				"id": "FEET",
				"convert": "ft",
				"abbr": "ft"
			},
			{
				"name": "inch",
				"id": "INCH",
				"convert": "in",
				"abbr": "in"
			},
			{
				"name": "yard",
				"id": "YARD",
				"convert": "yd",
				"abbr": "yd"
			},
			{
				"name": "miles",
				"id": "MILES",
				"convert": "mi",
				"abbr": "mi"
			},
			{
				"name": "microns",
				"id": "MICRONS",
				"abbr": "μ",
				"convert": "um"
			}
		]
	},
	{
		"name": "Mass",
		"id": "MASS",
		"convertable": true,
		"units": [
			{
				"name": "milligram",
				"id": "MILLIGRAM",
				"convert": "mg",
				"abbr": "mg"
			},
			{
				"name": "gram",
				"id": "GRAM",
				"convert": "g",
				"abbr": "g"
			},
			{
				"name": "kilogram",
				"id": "KILOGRAM",
				"convert": "kg",
				"abbr": "kg"
			},
			{
				"name": "pound",
				"id": "POUND",
				"convert": "lb",
				"abbr": "lb"
			},
			{
				"name": "pound_mass",
				"id": "POUNDMASS",
				"convert": "lbm",
				"abbr": "lbm"
			},
			{
				"name": "oz",
				"id": "OZ",
				"convert": "oz",
				"abbr": "oz"
			},
			{
				"name": "ton",
				"id": "TON",
				"convert": "t",
				"abbr": "T"
			},
			{
				"name": "metric_ton",
				"id": "METRIC_TON",
				"convert": "mt",
				"abbr": "MT"
			}
		]
	},
	{
		"name": "Time",
		"id": "TIME",
		"convertable": true,
		"units": [
			{
				"name": "millisecond",
				"id": "MILLISECOND",
				"abbr": "msec",
				"convert": "ms"
			},
			{
				"name": "second",
				"id": "SECOND",
				"abbr": "s",
				"convert": "s"
			},
			{
				"name": "minute",
				"id": "MINUTE",
				"abbr": "min",
				"convert": "min"
			},
			{
				"name": "hour",
				"id": "HOUR",
				"abbr": "hr",
				"convert": "hr"
			},
			{
				"name": "day",
				"id": "DAY",
				"abbr": "day",
				"convert": "d"
			},
			{
				"name": "year",
				"id": "YEAR",
				"abbr": "yr",
				"convert": "yr"
			}
		]
	},
	{
		"name": "Electric Current",
		"id": "ELEC_CURRENT",
		"convertable": true,
		"units": [
			{
				"name": "ampere",
				"id": "AMPERE",
				"abbr": "A",
				"convert": "A"
			},
			{
				"name": "milliampere",
				"id": "MILLIAMPERE",
				"abbr": "mA",
				"convert": "mA"
			},
			{
				"name": "microampere",
				"id": "MICROAMPERE",
				"abbr": "μA",
				"convert": "μA"
			},
			{
				"name": "kiloampere",
				"id": "KILOAMPERE",
				"abbr": "kA",
				"convert": "kA"
			}
		]
	},
	{
		"name": "Energy",
		"id": "ENERGY",
		"units": [
			{
				"name": "joule",
				"id": "JOULE",
				"abbr": "J",
				"convert": "J"
			}
		]
	},
	{
		"name": "Temperature",
		"id": "TEMPERATURE",
		"convertable": true,
		"units": [
			{
				"name": "kelvin",
				"id": "DEG_KELVIN",
				"convert": "K",
				"abbr": "°K"
			},
			{
				"name": "fahrenheit",
				"id": "DEG_FAHRENHEIT",
				"convert": "F",
				"abbr": "°F"
			},
			{
				"name": "celsius",
				"id": "DEG_CELSIUS",
				"convert": "C",
				"abbr": "°C"
			},
			{
				"name": "rankine",
				"id": "DEG_RANKINE",
				"convert": "R",
				"abbr": "°R"
			}
		],
		"conversions": [
			{
				"name": "celsius to fahrenheit",
				"id": "C_TO_F",
				"unit": "DEG_FAHRENHEIT",
				"offset": 32,
				"multiplier": 1.8
			},
			{
				"name": "fahrenheit to celsius",
				"id": "F_TO_C",
				"unit": "DEG_CELSIUS",
				"offset": -17.77792,
				"multiplier": 0.55556
			}
		]
	},
	{
		"name": "Amount of Substance",
		"id": "AMOUNT",
		"units": [
			{
				"name": "mol",
				"id": "MOLE"
			}
		]
	},
	{
		"name": "Luminance",
		"id": "LUMINANCE",
		"units": [
			{
				"name": "candela_per_meter2",
				"id": "CANDELA_PER_METER2",
				"abbr": "cd/m²"
			}
		]
	},
	{
		"name": "Luminous Flux",
		"id": "LUMINOUS_FLUX",
		"units": [
			{
				"name": "lumens",
				"id": "LUMENS",
				"abbr": "lm"
			}
		]
	},
	{
		"name": "Luminous Intensity",
		"id": "LUMINOUS_INTENSITY",
		"units": [
			{
				"name": "candela",
				"id": "CANDELA",
				"abbr": "cd"
			}
		]
	},
	{
		"name": "Percentage",
		"id": "PERCENTAGE",
		"units": [
			{
				"name": "percent",
				"id": "PERCENT",
				"abbr": "%"
			}
		]
	},
	{
		"name": "Number",
		"id": "NUMBER"
	},
	{
		"name": "Acceleration",
		"id": "ACCELERATION",
		"convertable": true,
		"units": [
			{
				"name": "meter_per_sec2",
				"id": "METER_PER_SEC2",
				"convert": "m/s2",
				"abbr": "m/s²"
			},
			{
				"name": "standard gravity",
				"id": "STANDARD_GRAVITY",
				"convert": "g-force",
				"abbr": "g₀"
			},
			{
				"name": "feet_per_sec2",
				"id": "FEET_PER_SEC2",
				"convert": "ft/s2",
				"abbr": "ft/s²"
			},
			{
				"name": "in_per_sec2",
				"id": "INCH_PER_SEC2",
				"convert": "in/s2",
				"abbr": "in/s²"
			}
		]
	},
	{
		"name": "Angular Acceleration",
		"id": "ANGULAR_ACCEL",
		"convertable": true,
		"units": [
			{
				"name": "rad_per_sec2",
				"id": "RAD_PER_SEC2",
				"convert": "av-rad/s",
				"abbr": "rad/s²"
			},
			{
				"name": "deg_per_sec2",
				"id": "DEG_PER_SEC2",
				"convert": "av-deg/s",
				"abbr": "deg/s²"
			},
			{
				"name": "rotations_per_min2",
				"id": "ROTATIONS_PER_MIN2",
				"convert": "av-rpm",
				"abbr": "r/min²"
			}
		]
	},
	{
		"name": "Angular Velocity",
		"id": "ANGULAR_VEL",
		"convertable": true,
		"units": [
			{
				"name": "rad_per_sec",
				"id": "RAD_PER_SEC",
				"convert": "av-rad/s",
				"abbr": "rad/s"
			},
			{
				"name": "rad_per_min",
				"id": "RAD_PER_MIN",
				"convert": "av-rad/m",
				"abbr": "rad/m"
			},
			{
				"name": "rad_per_hour",
				"id": "RAD_PER_HOUR",
				"convert": "av-rad/hr",
				"abbr": "rad/hr"
			},
			{
				"name": "deg_per_sec",
				"id": "DEG_PER_SEC",
				"convert": "av-deg/s",
				"abbr": "°/s"
			},
			{
				"name": "deg_per_min",
				"id": "DEG_PER_MIN",
				"convert": "av-deg/m",
				"abbr": "°/m"
			},
			{
				"name": "deg_per_hour",
				"id": "DEG_PER_HOUR",
				"convert": "av-deg/hr",
				"abbr": "°/hr"
			},
			{
				"name": "rotations_per_min",
				"id": "ROTATIONS_PER_MIN",
				"convert": "av-rpm",
				"abbr": "rpm"
			}
		]
	},
	{
		"name": "Area",
		"id": "AREA",
		"convertable": true,
		"units": [
			{
				"name": "mm2",
				"id": "MILLIMETER2",
				"convert": "mm2",
				"abbr": "mm²"
			},
			{
				"name": "cm2",
				"id": "CENTIMETER2",
				"convert": "cm2",
				"abbr": "cm²"
			},
			{
				"name": "meter2",
				"id": "METER2",
				"convert": "m2",
				"abbr": "m²"
			},
			{
				"name": "kilometer2",
				"id": "KILOMETER2",
				"convert": "km2",
				"abbr": "km²"
			},
			{
				"name": "feet2",
				"id": "FEET2",
				"convert": "ft2",
				"abbr": "ft²"
			},
			{
				"name": "inch2",
				"id": "INCH2",
				"convert": "in2",
				"abbr": "in²"
			},
			{
				"name": "mile2",
				"id": "MILE2",
				"convert": "mi2",
				"abbr": "mi²"
			},
			{
				"name": "acre",
				"id": "ACRE",
				"convert": "ac"
			}
		]
	},
	{
		"name": "Data",
		"id": "DATA",
		"units": [
			{
				"id": "BYTE",
				"name": "byte",
				"abbr": "B",
				"convert": "B"
			},
			{
				"id": "KILOBYTE",
				"name": "kilobyte",
				"abbr": "KB",
				"convert": "KB"
			},
			{
				"id": "MEGABYTE",
				"name": "megabyte",
				"abbr": "MB",
				"convert": "MB"
			},
			{
				"id": "GIGABYTE",
				"name": "gigabyte",
				"abbr": "GB",
				"convert": "GB"
			},
			{
				"id": "TERABYTE",
				"name": "terabyte",
				"abbr": "TB",
				"convert": "TB"
			}
		]
	},
	{
		"name": "Capacitance",
		"id": "CAPACITANCE",
		"convertable": true,
		"units": [
			{
				"name": "farad",
				"id": "FARAD",
				"convert": "f",
				"abbr": "F"
			},
			{
				"name": "microfarad",
				"id": "MICROFARAD",
				"convert": "μF",
				"abbr": "μF"
			},
			{
				"name": "millifarad",
				"id": "MILLIFARAD",
				"convert": "mF",
				"abbr": "mF"
			},
			{
				"name": "nanofarad",
				"id": "NANOFARAD",
				"convert": "nF",
				"abbr": "nF"
			},
			{
				"name": "picofarad",
				"id": "PICOFARAD",
				"convert": "pF",
				"abbr": "pF"
			}
		]
	},
	{
		"name": "Dynamic Viscosity",
		"id": "DYNAMIC_VISCOSITY",
		"convertable": true,
		"units": [
			{
				"name": "pascal_sec",
				"id": "PASCAL_SEC",
				"abbr": "Pa·s",
				"convert": "pa-s"
			},
			{
				"name": "millipascal_sec",
				"id": "MILLIPASCAL_SEC",
				"abbr": "mPa·s",
				"convert": "mpa-s"
			},
			{
				"name": "poise",
				"id": "POISE",
				"abbr": "P",
				"convert": "P"
			}
		]
	},
	{
		"name": "Kinematic Viscosity",
		"id": "KINEMATIC_VISCOSITY",
		"convertable": true,
		"units": [
			{
				"name": "centistokes",
				"id": "CENTISTOKES",
				"abbr": "cSt",
				"convert": "cSt"
			},
			{
				"name": "stokes",
				"id": "STOKES",
				"abbr": "St",
				"convert": "St"
			},
			{
				"name": "meters2_per_sec",
				"id": "METERS2_PER_SEC",
				"abbr": "m²/s",
				"convert": "m2/s"
			}
		]
	},
	{
		"name": "Flow Mass",
		"id": "FLOW_MASS",
		"convertable": true,
		"units": [
			{
				"name": "kg_per_sec",
				"id": "KG_PER_SEC",
				"convert": "kg/s",
				"abbr": "kg/s"
			},
			{
				"name": "lb_per_sec",
				"id": "LBS_PER_SEC",
				"convert": "lbs/s",
				"abbr": "lbs/s"
			}
		]
	},
	{
		"name": "Electrical Potential",
		"id": "ELEC_POTENTIAL",
		"units": [
			{
				"name": "volt",
				"id": "VOLT",
				"convert": "V",
				"abbr": "V"
			},
			{
				"name": "millivolt",
				"id": "MILLIVOLT",
				"convert": "mV",
				"abbr": "mV"
			},
			{
				"name": "kilovolt",
				"id": "KILOVOLT",
				"convert": "kV",
				"abbr": "kV"
			},
			{
				"name": "megavolt",
				"id": "MEGAVOLT",
				"convert": "MV",
				"abbr": "MV"
			},
			{
				"name": "microvolt",
				"id": "MICROVOLT",
				"convert": "μV",
				"abbr": "μV"
			}
		]
	},
	{
		"name": "Electrical Resistance",
		"id": "ELEC_RESISTANCE",
		"convertable": true,
		"units": [
			{
				"name": "ohm",
				"id": "OHM",
				"convert": "Ω",
				"abbr": "Ω"
			},
			{
				"name": "milliohm",
				"id": "MILLIOHM",
				"convert": "mΩ",
				"abbr": "mΩ"
			},
			{
				"name": "microohm",
				"id": "MICROOHM",
				"convert": "μΩ",
				"abbr": "μΩ"
			},
			{
				"name": "kiloohm",
				"id": "KILOOHM",
				"convert": "kΩ",
				"abbr": "kΩ"
			},
			{
				"name": "megaohm",
				"id": "MEGAOHM",
				"convert": "MΩ",
				"abbr": "MΩ"
			}
		]
	},
	{
		"name": "Inductance",
		"id": "INDUCTANCE",
		"units": [
			{
				"name": "Henry",
				"id": "HENRY",
				"abbr": "H"
			}
		]
	},
	{
		"name": "Electrical Conductance",
		"id": "ELEC_CONDUCTANCE",
		"units": [
			{
				"name": "Siemens",
				"id": "SIEMENS",
				"abbr": "S"
			}
		]
	},
	{
		"name": "Electrical Resistivity",
		"id": "ELEC_RESISTIVITY",
		"units": [
			{
				"name": "ohm_meter",
				"id": "OHM_METER",
				"abbr": "Ω⋅m"
			}
		]
	},
	{
		"name": "Flow",
		"id": "FLOW",
		"convertable": true,
		"units": [
			{
				"name": "meters3_per_sec",
				"id": "METERS3_PER_SEC",
				"abbr": "m³/s",
				"convert": "m3/s"
			},
			{
				"name": "percent",
				"id": "PERCENT",
				"abbr": "%"
			},
			{
				"name": "scfm",
				"id": "SCFM",
				"abbr": "SCFM",
				"convert": "ft3/min"
			},
			{
				"name": "scfh",
				"id": "SCFH",
				"abbr": "SCFH",
				"convert": "ft3/h"
			},
			{
				"name": "liters_per_sec",
				"id": "LITERS_PER_SEC",
				"abbr": "L/s",
				"convert": "l/s"
			},
			{
				"name": "liters_per_min",
				"id": "LITERS_PER_MIN",
				"abbr": "L/min",
				"convert": "l/min"
			},
			{
				"name": "gallons_per_min",
				"id": "GALLONS_PER_MIN",
				"abbr": "GPM",
				"convert": "gal/min"
			},
			{
				"name": "gallons_per_sec",
				"id": "GALLONS_PER_SEC",
				"abbr": "GPS",
				"convert": "gal/s"
			},
			{
				"name": "gallons_per_hour",
				"id": "GALLONS_PER_HOUR",
				"abbr": "GPH",
				"convert": "gal/h"
			},
			{
				"name": "standard_liters_per_second",
				"id": "STANDARD_LITERS_PER_SECOND",
				"convert": "l/s",
				"abbr": "SLPS"
			},
			{
				"name": "standard_liters_per_min",
				"id": "STANDARD_LITERS_PER_MIN",
				"abbr": "SLPM",
				"convert": "l/min"
			},
			{
				"name": "normal_meters3_per_hour",
				"id": "NORMAL_METERS3_PER_HOUR",
				"abbr": "NCMH",
				"convert": "m3/h"
			},
			{
				"name": "normal_meters3_per_minute",
				"id": "NORMAL_METERS3_PER_MINUTE",
				"abbr": "NCMM",
				"convert": "m3/min"
			},
			{
				"name": "normal_liters_per_sec",
				"id": "NORMAL_LITERS_PER_SEC",
				"abbr": "NLPS",
				"convert": "l/s"
			},
			{
				"name": "normal_liters_per_min",
				"id": "NORMAL_LITERS_PER_MIN",
				"abbr": "NLPM",
				"convert": "l/min"
			}
		]
	},
	{
		"name": "Frequency",
		"id": "FREQUENCY",
		"units": [
			{
				"name": "hertz",
				"id": "HERTZ",
				"abbr": "Hz",
				"convert": "hz"
			},
			{
				"name": "kilohertz",
				"id": "HERTZ",
				"abbr": "KHz",
				"convert": "KHz"
			},
			{
				"name": "megahertz",
				"id": "MEGAHERTZ",
				"abbr": "MHz",
				"convert": "MHz"
			}
		]
	},
	{
		"name": "Heat",
		"id": "HEAT",
		"convertable": true,
		"units": [
			{
				"name": "joule",
				"id": "JOULE",
				"convert": "J",
				"abbr": "J"
			},
			{
				"name": "btu",
				"id": "BTU",
				"convert": "btu",
				"abbr": "Btu"
			},
			{
				"name": "kilocalorie",
				"id": "KILOCALORIE",
				"convert": "kcal",
				"abbr": "kcal"
			},
			{
				"name": "calorie",
				"id": "CALORIE",
				"convert": "cal",
				"abbr": "cal"
			}
		]
	},
	{
		"name": "Humidity",
		"id": "HUMIDITY",
		"units": [
			{
				"name": "percent",
				"id": "PERCENT",
				"abbr": "%"
			}
		]
	},
	{
		"name": "Illuminance",
		"id": "ILLUMINANCE",
		"convertable": true,
		"units": [
			{
				"name": "lux",
				"id": "LUX",
				"convert": "lx"
			},
			{
				"name": "foot-candles",
				"id": "FOOT_CANDLES",
				"convert": "fc",
				"abbr": "fc"
			}
		]
	},
	{
		"name": "Jerk",
		"id": "JERK",
		"units": [
			{
				"name": "meter_per_sec3",
				"id": "METER_PER_SEC3",
				"abbr": "m/s³"
			}
		]
	},
	{
		"name": "Particles",
		"id": "PARTS_PER",
		"convertable": true,
		"units": [
			{
				"name": "ppm",
				"id": "PPM",
				"convert": "ppm",
				"abbr": "ppm"
			},
			{
				"name": "ppb",
				"id": "PPB",
				"convert": "ppb",
				"abbr": "ppb"
			},
			{
				"name": "ppt",
				"id": "PPT",
				"convert": "ppt",
				"abbr": "ppt"
			}
		]
	},
	{
		"name": "Density",
		"id": "DENSITY",
		"units": [
			{
				"name": "kg_per_m3",
				"id": "KG_PER_M3",
				"abbr": "kg/m³"
			}
		]
	},
	{
		"name": "Linear Density",
		"id": "LINEAR_DENSITY",
		"units": [
			{
				"name": "kilogram_per_meter",
				"id": "KILOGRAM_PER_METER",
				"abbr": "kg/m"
			}
		]
	},
	{
		"name": "URL",
		"id": "URL"
	},
	{
		"name": "Field Level",
		"id": "FIELD_LEVEL",
		"units": [
			{
				"name": "Decibel",
				"id": "DECIBEL",
				"abbr": "dB"
			}
		]
	},
	{
		"name": "pH",
		"id": "PH"
	},
	{
		"name": "Solid Angle",
		"id": "SOLID_ANGLE",
		"units": [
			{
				"name": "steradian",
				"id": "STERADIAN",
				"abbr": "sr"
			}
		]
	},
	{
		"name": "Plane Angle",
		"id": "ANGLE",
		"units": [
			{
				"name": "radian",
				"id": "RADIAN",
				"convert": "rad",
				"abbr": "rad"
			},
			{
				"name": "degree",
				"id": "DEGREE",
				"convert": "deg",
				"abbr": "°"
			},
			{
				"name": "arcminute",
				"id": "ARCMINUTE",
				"convert": "arcmin"
			},
			{
				"name": "arcsecond",
				"id": "ARCSECOND",
				"convert": "arcsec"
			}
		]
	},
	{
		"name": "Power",
		"id": "POWER",
		"convertable": true,
		"units": [
			{
				"name": "watt",
				"id": "WATT",
				"abbr": "W",
				"convert": "W"
			},
			{
				"name": "kilowatt",
				"id": "KILOWATT",
				"abbr": "kW",
				"convert": "kW"
			},
			{
				"name": "megawatt",
				"id": "MEGAWATT",
				"abbr": "MW",
				"convert": "MW"
			},
			{
				"name": "milliwatt",
				"id": "MILLIWATT",
				"abbr": "mW",
				"convert": "mW"
			},
			{
				"name": "microwatt",
				"id": "MICROWATT",
				"abbr": "μW",
				"convert": "μW"
			},
			{
				"name": "kilovoltamp",
				"id": "KILOVOLTAMP",
				"abbr": "kVA",
				"convert": "kva"
			},
			{
				"name": "voltamp",
				"id": "VOLTAMP",
				"abbr": "VA",
				"convert": "var"
			},
			{
				"name": "kilovoltamp_reactive",
				"id": "KILOVOLTAMP_REACTIVE",
				"abbr": "kVAR",
				"convert": "kvar"
			},
			{
				"name": "horsepower",
				"id": "HORSEPOWER",
				"abbr": "HP",
				"convert": "hp"
			}
		]
	},
	{
		"name": "Power Level",
		"id": "POWER_LEVEL",
		"units": [
			{
				"name": "decibel",
				"id": "DECIBEL",
				"abbr": "dB"
			}
		]
	},
	{
		"name": "Pressure",
		"id": "PRESSURE",
		"convertable": true,
		"units": [
			{
				"name": "millibar",
				"id": "MIL_BAR",
				"convert": "millibar",
				"abbr": "mbar"
			},
			{
				"name": "bar",
				"id": "BAR",
				"convert": "bar",
				"abbr": "bar"
			},
			{
				"name": "psi",
				"id": "PSI",
				"convert": "psi",
				"abbr": "psi"
			},
			{
				"name": "torr",
				"id": "TORR",
				"convert": "torr",
				"abbr": "Torr"
			},
			{
				"name": "pascal",
				"id": "PASCAL",
				"convert": "Pa",
				"abbr": "Pa"
			},
			{
				"name": "kilopascal",
				"id": "KILOPASCAL",
				"convert": "kPa",
				"abbr": "kPa"
			},
			{
				"name": "atmosphere",
				"id": "ATMOSPHERE",
				"convert": "atm",
				"abbr": "atm"
			},
			{
				"name": "newton_per_meter_2",
				"id": "NEWTON_PER_METER_2",
				"abbr": "N/m²",
				"convert": "N/m2"
			},
			{
				"name": "millimeters of mercury at 0C",
				"id": "MM_HG",
				"convert": "mmHg",
				"abbr": "mmHg"
			},
			{
				"name": "inH2O",
				"id": "IN_H2O",
				"convert": "inH2O",
				"abbr": "inH₂O"
			}
		]
	},
	{
		"name": "Speed",
		"id": "SPEED",
		"convertable": true,
		"units": [
			{
				"name": "meter_per_sec",
				"id": "METER_PER_SEC",
				"convert": "m/s",
				"abbr": "m/s"
			},
			{
				"name": "kilometer_per_hour",
				"id": "KILOMETER_PER_HOUR",
				"abbr": "km/h",
				"convert": "km/h"
			},
			{
				"name": "mph",
				"id": "MPH",
				"abbr": "mph",
				"convert": "m/h"
			},
			{
				"name": "inch_per_sec",
				"id": "INCH_PER_SEC",
				"convert": "in/s",
				"abbr": "ips"
			},
			{
				"name": "knots",
				"id": "KNOTS",
				"convert": "knot",
				"abbr": "kn"
			},
			{
				"name": "feet_per_second",
				"id": "FEET_PER_SECOND",
				"convert": "ft/s",
				"abbr": "fps"
			}
		]
	},
	{
		"name": "Torque",
		"id": "TORQUE",
		"convertable": true,
		"units": [
			{
				"name": "newton_meter",
				"id": "NEWTON_METER",
				"convert": "n-m",
				"abbr": "N⋅m"
			},
			{
				"name": "foot_pounds",
				"id": "FOOT_POUNDS",
				"convert": "lbf-ft",
				"abbr": "lbf⋅ft"
			},
			{
				"name": "inch_pounds",
				"id": "INCH_POUNDS",
				"convert": "lbf-in",
				"abbr": "lbf⋅in"
			}
		]
	},
	{
		"name": "Velocity",
		"id": "VELOCITY",
		"convertable": true,
		"units": [
			{
				"name": "meter_per_sec",
				"id": "METER_PER_SEC",
				"convert": "m/s",
				"abbr": "m/s"
			},
			{
				"name": "millimeter_per_sec",
				"id": "MILLIMETER_PER_SEC",
				"convert": "mm/s",
				"abbr": "mm/s"
			},
			{
				"name": "mph",
				"id": "MPH",
				"abbr": "mph",
				"convert": "m/h"
			},
			{
				"name": "inch_per_sec",
				"id": "INCH_PER_SEC",
				"convert": "in/s",
				"abbr": "ips"
			},
			{
				"name": "feet_per_second",
				"id": "FEET_PER_SECOND",
				"convert": "ft/s",
				"abbr": "fps"
			}
		]
	},
	{
		"name": "Volume",
		"id": "VOLUME",
		"convertable": true,
		"units": [
			{
				"name": "m3",
				"id": "METER3",
				"convert": "m3",
				"abbr": "m³"
			},
			{
				"name": "litre",
				"id": "LITRE",
				"convert": "litre",
				"abbr": "l"
			},
			{
				"name": "millilitre",
				"id": "MILLILITRE",
				"convert": "ml",
				"abbr": "ml"
			},
			{
				"name": "cm3",
				"id": "CENTIMETER3",
				"convert": "cm3",
				"abbr": "cm³"
			},
			{
				"name": "mm3",
				"id": "MILLIMETER3",
				"convert": "mm3",
				"abbr": "mm³"
			},
			{
				"name": "ft3",
				"id": "FEET3",
				"convert": "ft3",
				"abbr": "ft³"
			},
			{
				"name": "fluid ounces",
				"id": "FLUID_OUNCES",
				"convert": "fl-oz",
				"abbr": "fl-oz"
			},
			{
				"name": "gallon",
				"id": "GALLON",
				"convert": "gal",
				"abbr": "gal"
			},
			{
				"name": "quart",
				"id": "QUART",
				"convert": "qt",
				"abbr": "qt"
			},
			{
				"name": "pint",
				"id": "PINT",
				"convert": "pnt",
				"abbr": "pt"
			},
			{
				"name": "in3",
				"id": "INCH3",
				"convert": "in3",
				"abbr": "in³"
			},
			{
				"name": "imperial_gallon",
				"id": "IMPERIAL_GALLON",
				"convert": "igal",
				"abbr": "Igal"
			}
		]
	},
	{
		"name": "Weight",
		"id": "WEIGHT",
		"convertable": true,
		"units": [
			{
				"name": "newton",
				"id": "NEWTON",
				"abbr": "N",
				"convert": "N"
			},
			{
				"name": "pound",
				"id": "POUND",
				"abbr": "lb",
				"convert": "lbf"
			},
			{
				"name": "oz",
				"id": "OZ",
				"abbr": "oz",
				"convert": "ozf"
			},
			{
				"name": "ton",
				"id": "TON",
				"abbr": "T",
				"convert": "tonf"
			},
			{
				"name": "metric_ton",
				"id": "METRIC_TON",
				"convert": "mtf",
				"abbr": "MT"
			}
		]
	},
	{
		"name": "Location",
		"id": "LOCATION",
		"units": [
			{
				"name": "latlong",
				"id": "LAT_LONG",
				"abbr": "latlng"
			},
			{
				"name": "latlongalt",
				"id": "LAT_LONG_ALT",
				"abbr": "latlngalt"
			}
		]
	},
	{
		"name": "Currency",
		"id": "CURRENCY",
		"units": [
			{
				"name": "USD ($)",
				"id": "USD"
			},
			{
				"name": "EUR (€)",
				"id": "EURO"
			},
			{
				"name": "JPY (¥)",
				"id": "JPY"
			},
			{
				"name": "GBP (£)",
				"id": "GBP"
			},
			{
				"name": "AUD (A$)",
				"id": "AUD"
			},
			{
				"name": "CAD (C$)",
				"id": "CAD"
			},
			{
				"name": "NTD (NT$)",
				"id": "NTD"
			},
			{
				"name": "CNY (元)",
				"id": "CNY"
			},
			{
				"name": "MXN ($)",
				"id": "MXN"
			}
		]
	},
	{
		"name": "Battery",
		"id": "BATTERY_PERCENTAGE",
		"units": [
			{
				"name": "percent",
				"id": "PERCENT",
				"abbr": "%"
			}
		]
	},
	{
		"name": "Signal Strength",
		"id": "SIGNAL_STRENGTH_PERCENTAGE",
		"units": [
			{
				"name": "percent",
				"id": "PERCENT",
				"abbr": "%"
			}
		]
	},
	{
		"name": "Work",
		"id": "WORK",
		"convertable": true,
		"units": [
			{
				"name": "joule",
				"id": "JOULE",
				"abbr": "J",
				"convert": "J"
			},
			{
				"name": "foot_pound",
				"id": "FOOT_POUND",
				"convert": "ft-lb",
				"abbr": "ft⋅lb"
			}
		]
	}
]
]]

return from_json(types);
