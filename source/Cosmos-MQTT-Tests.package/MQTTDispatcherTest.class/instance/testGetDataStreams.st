tests
testGetDataStreams

	| dispatcher outgoingMessage |

	dispatcher := MQTTDispatcher new.
	dispatcher
		when: 'GET/data-channel/(.+)' asRegex
		do: [ :topic :message :matches | dispatcher publishMessage: (dataInterface currentSnapshotOfChannelIdentifiedBy: (matches at: 1) asNumber) toTopic: message asString ].
	dispatcher
		handleMessage:
			(MQTTPublish new
				topic: ('GET/data-channel/{identifier}' format: {(#identifier -> self channelId)} asDictionary);
				message: '/the/response/topic').
	outgoingMessage := dispatcher nextOutgoingMessage.
	self assert: outgoingMessage key equals: '/the/response/topic'.
	self assert: outgoingMessage value equals: self expectedGetDataStreamsResponse