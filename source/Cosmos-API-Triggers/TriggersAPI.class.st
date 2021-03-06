Class {
	#name : #TriggersAPI,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Cosmos-API-Triggers'
}

{ #category : #'instance creation' }
TriggersAPI class >> workingWithin: aContext [ 
	
	^ self new initializeWorkingWithin: aContext 
]

{ #category : #API }
TriggersAPI >> deregisterNamed: aName [

	| name |

	name := aName replaceAll: $_ with: Character space.

	self triggerManagementSystem deregisterNamed: name.

	^ ZnResponse noContent
]

{ #category : #initialization }
TriggersAPI >> initializeWorkingWithin: aContext [

	context := aContext
]

{ #category : #API }
TriggersAPI >> registerHandling: anHttpRequest [

	^ [ [ context
		register: anHttpRequest contents
		encodedAs: anHttpRequest contentType.

	ZnResponse created: anHttpRequest requestLine uri ]
		on: ConflictingObjectFound
		do: [ :signal | HTTPClientError signalConflict: signal messageText ] ]
		on: KeyNotFound , DecodingFailed
		do: [ :signal | 
			HTTPClientError
				signalBadRequest: signal messageText ]
]

{ #category : #systems }
TriggersAPI >> triggerManagementSystem [
	
	^ context triggerManagementSystem
]

{ #category : #API }
TriggersAPI >> triggersHandling: anHttpRequest [

	| mimeType |

	mimeType := ZnMimeType fromString: anHttpRequest accept.

	^ [ [ [ ZnResponse
		ok:
			(context
				encode: self triggerManagementSystem triggers
				at: #triggers
				to: mimeType
				within: context) ]
		on: ConflictingObjectFound
		do: [ :signal | HTTPClientError signalConflict: signal messageText ] ]
		on: MappingNotFound
		do: [ :signal | HTTPClientError signalBadRequest: signal messageText ] ]
		on: DecodingFailed
		do: [ :signal | HTTPClientError signalBadRequest: signal messageText ]
]
