Class {
	#name : #MappingRule,
	#superclass : #Object,
	#instVars : [
		'isDefault',
		'mediaType',
		'objectType',
		'mapper'
	],
	#category : #'Cosmos-API-Model'
}

{ #category : #'private - instance creation' }
MappingRule class >> between: anObjectType and: aMediaType using: aMapper [

	^ self new
		initializeBetween: anObjectType
		and: aMediaType
		using: aMapper
]

{ #category : #'instance creation' }
MappingRule class >> decoding: aMediaType to: anObjectType using: aReader [

	^ self between: anObjectType and: aMediaType using: aReader
]

{ #category : #'instance creation' }
MappingRule class >> encoding: anObjectType to: aMediaType using: aWriter [

	^ self between: anObjectType and: aMediaType using: aWriter
]

{ #category : #applying }
MappingRule >> applyOn: anObjectToEncode within: aContext [

	^ mapper cull: anObjectToEncode cull: aContext
]

{ #category : #configuring }
MappingRule >> beDefault [

	isDefault := true
]

{ #category : #initialization }
MappingRule >> initializeBetween: anObjectType and: aMediaType using: aMapper [ 

	mapper := aMapper.
	mediaType := aMediaType.
	objectType := anObjectType.
	
	isDefault := false
]

{ #category : #testing }
MappingRule >> isDefault [

	^ isDefault
]

{ #category : #accessing }
MappingRule >> mediaType [

	^ mediaType
]

{ #category : #accessing }
MappingRule >> objectType [

	^ objectType
]
