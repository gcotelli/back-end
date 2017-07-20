tests
testDispatchProcess

	| dispatcher semaphore |

	semaphore := Semaphore new.
	dispatcher := MQTTDispatcher new.
	[ dispatcher when: self topicForThisTest asRegex do: [ :topic :message :matches | semaphore signal ].
	dispatcher queueIncomingMessage: (MQTTPublish new topic: self topicForThisTest).
	dispatcher startUp.
	self should: [ semaphore wait ] notTakeMoreThanMilliseconds: 500 ]
		ensure: [ dispatcher shutDown ]