initialization
dispatchProcessBlock

	^ [ [ self handleMessage: incomingMessages next ] repeat ]