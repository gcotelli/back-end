Extension { #name : #SystemBasedUserStoryTest }

{ #category : #'*Cosmos-Identifier-Tests' }
SystemBasedUserStoryTest >> currentIdentifier [

	^ 1
]

{ #category : #'*Cosmos-Identifier-Tests' }
SystemBasedUserStoryTest >> identifierProvider [

	^ FixedIdentifierProvider providing: self currentIdentifier
]

{ #category : #'*Cosmos-Identifier-Tests' }
SystemBasedUserStoryTest >> identifierSystem [

	^ rootSystem systemImplementing: #IdentifierSystemInterface
]

{ #category : #'*Cosmos-Identifier-Tests' }
SystemBasedUserStoryTest >> requireIdentifierSystem [

	self requireMetadataSystem.
	systemBuilder add: (IdentifierSystem using: self identifierProvider)
]
