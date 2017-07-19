tests
testGetDataStreams

	| dispatcher |

	self fail.
	dispatcher := MQTTDispatcher new.
	dispatcher
		handleMessage:
			(MQTTPublish new
				topic: ('GET/data-channel/{identifier}' format: {(#identifier -> self channelId)} asDictionary);
				message: 'TODO: Define mqtt get behavior. Pass response topic as message?').

	self assert: '' equals: self expectedGetDataStreamsResponse