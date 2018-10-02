Class {
	#name : #ReflectiveRoutesConfiguratorTest,
	#superclass : #TestCase,
	#category : #'Cosmos-API-Common-Tests-Model'
}

{ #category : #tests }
ReflectiveRoutesConfiguratorTest >> testAddingRoutes [

	| teapot webService |

	teapot := Teapot on.

	webService := PetsWebService managing: OrderedCollection new.

	(ReflectiveRoutesConfigurator appliedTo: teapot) 
		addRoutesOf: webService.

	self assert: teapot routes size equals: 3
]