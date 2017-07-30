tests
testGetDataStreams

	| dispatcher outgoingMessage |

	dispatcher := MQTTDispatcher new.
	dispatcher
		when: 'GET/data-streams' asRegex
		do: [ :topic :message :matches | dispatcher publishMessage: self expectedGetDataStreamsResponse toTopic: message asString ].
	dispatcher
		handleMessage:
			(MQTTPublish new
				topic: 'GET/data-streams' ;
				message: '/the/response/topic').
	outgoingMessage := dispatcher nextOutgoingMessage.
	self assert: outgoingMessage key equals: '/the/response/topic'.
	self assert: outgoingMessage value equals: self expectedGetDataStreamsResponse