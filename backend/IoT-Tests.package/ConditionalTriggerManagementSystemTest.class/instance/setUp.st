running
setUp

	timeSource := FixedTimeSource
		on: September tenth , 2014
		at: TimeOfDay noon.

	rootSystem := CompositeSystem named: 'IoT for testing'.

	(OrderedCollection
		with: (TimeSystem using: timeSource)
		with: ConditionalTriggerManagementSystem new
		with: (DataManagementSystem using: SequentialNumberProvider new))
		do: [ :subsystem | rootSystem register: subsystem ].
	
	rootSystem startUp