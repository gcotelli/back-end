Class {
	#name : #ActionsWebService,
	#superclass : #RESTfulWebService,
	#instVars : [
		'cosmos'
	],
	#category : #'Cosmos-API-Actions'
}

{ #category : #'instance creation' }
ActionsWebService class >> workingWith: aCosmosSystem [
	
	^ self new initializeWorkingWith: aCosmosSystem
]

{ #category : #'private - systems' }
ActionsWebService >> actionManagementSystem [

	^ cosmos systemImplementing: #ActionManagementSystemInterface
]

{ #category : #API }
ActionsWebService >> createActionBasedOn: anHttpRequest within: aContext [

	^ self
		withCreatedResourceDo: [ :action | self actionManagementSystem register: action ]
		decodedUsing: #actions
		basedOn: anHttpRequest
		within: aContext
]

{ #category : #API }
ActionsWebService >> deleteActionBasedOn: anHttpRequest within: aContext [

	| name |

	name := (anHttpRequest at: #name) replaceAll: $_ with: Character space.

	self actionManagementSystem
		actionNamed: name
		ifFound: [ :action | self actionManagementSystem deregister: action ]
		ifNone: [ ObjectNotFound signal ].

	^ ZnResponse noContent
]

{ #category : #API }
ActionsWebService >> getActionsBasedOn: anHttpRequest within: aContext [

	^ self
		get: [ self actionManagementSystem actions ]
		asCollectionEncodedUsing: #actions
		basedOn: anHttpRequest
		within: aContext
]

{ #category : #'private - systems' }
ActionsWebService >> identifierSystem [

	^ cosmos systemImplementing: #IdentifierSystemInterface
]

{ #category : #initialization }
ActionsWebService >> initializeWorkingWith: aCosmosSystem [

	cosmos := aCosmosSystem
]

{ #category : #'private - API' }
ActionsWebService >> locationOf: anAction [

	| baseUrl |

	baseUrl := baseUrlOptional
		withContentDo: [ :theBaseUrl | theBaseUrl ]
		ifUnused: [ '' asZnUrl ].

	^ '<1p>/<2p>'
		expandMacrosWith: baseUrl / 'actions' asZnUrl
		with: (self identifierSystem identifierOf: anAction)
]

{ #category : #specification }
ActionsWebService >> specification [
	
	^ ActionsWebServiceSpecification new
]
