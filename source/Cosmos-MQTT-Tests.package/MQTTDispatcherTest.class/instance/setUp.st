tests
setUp

	super setUp.
	dataInterface := DataInterface workingWith: rootSystem.
	(SensorsSampleAddOn on: rootSystem) install