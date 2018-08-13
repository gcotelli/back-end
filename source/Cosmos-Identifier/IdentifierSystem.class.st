Class {
	#name : #IdentifierSystem,
	#superclass : #System,
	#instVars : [
		'identifierProvider',
		'metadataSystem'
	],
	#category : #'Cosmos-Identifier'
}

{ #category : #'system specification' }
IdentifierSystem class >> implementedInterface [

	^ SystemInterface >> #IdentifierSystemInterface
]

{ #category : #'instance creation' }
IdentifierSystem class >> using: anIdentifierProvider [

	^ self new initializeUsing: anIdentifierProvider 
]

{ #category : #initialization }
IdentifierSystem >> initializeUsing: anIdentifierProvider [

	super initialize.
	identifierProvider := anIdentifierProvider.

	metadataSystem := self unresolvedSystemDependencyTo: #MetadataSystemInterface
]

{ #category : #'private - providing identifier' }
IdentifierSystem >> next [
	
	^identifierProvider next 
]

{ #category : #querying }
IdentifierSystem >> objectIdentifiedBy: anIdentifier [

	^ metadataSystem describedObjectBy: anIdentifier as: #identifier ifNone: nil
]

{ #category : #managing }
IdentifierSystem >> registerIdentifierFor: anObject [
	
	metadataSystem
		register:
			(Metadata
				attaching: self next
				as: #identifier
				of: anObject)
]

{ #category : #initialization }
IdentifierSystem >> resolveDependecies [

	metadataSystem := self resolveSystemDependencyTo: #MetadataSystemInterface
]