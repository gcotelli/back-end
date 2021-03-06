Class {
	#name : #DataStreamsRESTfulWebService,
	#superclass : #RESTfulWebService,
	#instVars : [
		'cosmos'
	],
	#category : #'Cosmos-API-Data'
}

{ #category : #'instance creation' }
DataStreamsRESTfulWebService class >> workingWith: aCosmosSystem [
	
	^ self new initializeWorkingWith: aCosmosSystem
]

{ #category : #API }
DataStreamsRESTfulWebService >> createStreamBasedOn: anHttpRequest within: aContext [

	^ [ self
		withCreatedResourceDo: [ :dataStream | self dataManagementSystem register: dataStream ]
		decodedUsing: self dataStreamsKey
		basedOn: anHttpRequest
		within: aContext ]
		on: InstanceCreationFailed
		do: [ :signal | HTTPClientError signalBadRequest: signal messageText ]
]

{ #category : #'private - systems' }
DataStreamsRESTfulWebService >> dataManagementSystem [

	^ cosmos systemImplementing: #DataManagementSystemInterface
]

{ #category : #'private - object types' }
DataStreamsRESTfulWebService >> dataStreamsKey [

	^ #data_streams
]

{ #category : #API }
DataStreamsRESTfulWebService >> deleteStreamBasedOn: anHttpRequest within: aContext [

	^ [ self
		withStreamRequestedIn: anHttpRequest
		do: [ :dataStream | self dataManagementSystem deregister: dataStream ].

	ZnResponse noContent ]
		on: ObjectNotFound
		do: [ :signal | HTTPClientError signalNotFound: signal messageText ]
]

{ #category : #API }
DataStreamsRESTfulWebService >> getPointsBasedOn: anHttpRequest within: aContext [

	| mediaType resourceCollection encodedResourceCollection |

	mediaType := self targetMediaTypeFrom: anHttpRequest.
		resourceCollection := self
		evaluateQuery: [ (self dataManagementSystem
				streamIdentifiedBy: (anHttpRequest at: #identifier)) dataPoints ].

	encodedResourceCollection := self
		encode: resourceCollection
		at: #data_points
		to: mediaType
		within: aContext.
		
	^ ZnResponse ok: encodedResourceCollection 
]

{ #category : #API }
DataStreamsRESTfulWebService >> getStreamBasedOn: anHttpRequest within: aContext [

	^ [ self
			get: [ 
				aContext hold: self metadataSystem under: #metadata_system.
				self streamRequestedIn: anHttpRequest ]
			encodedUsing: #data_streams
			basedOn: anHttpRequest
			within: aContext ]
		on: DataStreamIsEmpty
		do: [ :signal | signal resume: 'N/A' ]
]

{ #category : #API }
DataStreamsRESTfulWebService >> getStreamsBasedOn: anHttpRequest within: aContext [

	^ [ self
			get: [ 
				aContext hold: self metadataSystem under: #metadata_system.
				self dataManagementSystem streams ]
			asCollectionEncodedUsing: #data_streams
			basedOn: anHttpRequest
			within: aContext ]
		on: DataStreamIsEmpty
		do: [ :signal | signal resume: 'N/A' ]
]

{ #category : #'private - systems' }
DataStreamsRESTfulWebService >> identifierSystem [

	^ cosmos systemImplementing: #IdentifierSystemInterface
]

{ #category : #initialization }
DataStreamsRESTfulWebService >> initializeWorkingWith: aCosmosSystem [

	cosmos := aCosmosSystem
]

{ #category : #'private - API' }
DataStreamsRESTfulWebService >> locationOf: aDataStream [

	| baseUrl |

	baseUrl := baseUrlOptional
		withContentDo: [ :theBaseUrl | theBaseUrl ]
		ifUnused: [ '' asZnUrl ].

	^ '<1p>/<2p>'
		expandMacrosWith: baseUrl / 'data-streams' asZnUrl
		with: (self identifierSystem identifierOf: aDataStream)
]

{ #category : #'private - systems' }
DataStreamsRESTfulWebService >> metadataSystem [

	^ cosmos systemImplementing: #MetadataSystemInterface
]

{ #category : #specification }
DataStreamsRESTfulWebService >> specification [

	^ DataStreamsRESTfulWebServiceSpecification new
]

{ #category : #'private - API' }
DataStreamsRESTfulWebService >> streamRequestedIn: anHttpRequest [

	^ self dataManagementSystem
		streamIdentifiedBy: (anHttpRequest at: #identifier)
]

{ #category : #'private - API' }
DataStreamsRESTfulWebService >> withStreamRequestedIn: anHttpRequest do: aBlock [

	aBlock value: (self streamRequestedIn: anHttpRequest)
]
