tests
testRegisterDataPoint

	| dispatcher |

	dispatcher := MQTTDispatcher new.
	dispatcher
		when: 'POST/data-channel/(.+)/(.+)' asRegex
		do: [ :topic :message :matches | dataInterface register: (NeoJSONReader fromString: message asString) toStreamNamed: (matches at: 2) ofChannelIdentifiedBy: (matches at: 1) asNumber ].
	dispatcher
		handleMessage:
			(MQTTPublish new
				topic: ('POST/data-channel/{identifier}/Temperature' format: {(#identifier -> self channelId)} asDictionary);
				message: '16.5' asByteArray).
	self dataManagementSystem
		streamNamed: 'Temperature'
		ofChannelIdentifiedBy: self channelId
		ifFound: [ :stream | self assert: stream currentValue equals: 16.5 ]
		ifNone: [ self fail ]