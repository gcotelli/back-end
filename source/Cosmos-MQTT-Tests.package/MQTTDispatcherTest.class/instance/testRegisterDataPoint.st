tests
testRegisterDataPoint

	| dispatcher |

	dispatcher := MQTTDispatcher new.
	dispatcher
		when: 'POST/data-streams/(.+)' asRegex
		do: [ :topic :message :matches | 
			dataInterface
				register: (NeoJSONReader fromString: message asString)
				toStreamNamed: (matches at: 1) ].
	dispatcher
		handleMessage:
			(MQTTPublish new
				topic: 'POST/data-streams/Temperature';
				message: '16.5' asByteArray).
	self dataManagementSystem
		streamNamed: 'Temperature'
		ifFound: [ :stream | self assert: stream currentValue equals: 16.5 ]
		ifNone: [ self fail ]