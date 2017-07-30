tests
setUp

	super setUp.
	dataInterface := RESTDataInterface workingWith: rootSystem.
	(SensorsSampleAddOn on: rootSystem) install