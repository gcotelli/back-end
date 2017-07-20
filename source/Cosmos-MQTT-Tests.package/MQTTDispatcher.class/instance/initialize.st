initialization
initialize

	rules := Dictionary new.
	incomingMessages := AtomicSharedQueue new.
	outgoingMessages := AtomicSharedQueue new.
	dispatchProcess := self dispatchProcessBlock newProcess
		name: self class dispatchProcessName;
		yourself