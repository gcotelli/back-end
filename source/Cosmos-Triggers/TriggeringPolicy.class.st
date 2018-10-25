Class {
	#name : #TriggeringPolicy,
	#superclass : #Object,
	#category : #'Cosmos-Triggers-Model'
}

{ #category : #evaluating }
TriggeringPolicy >> apply: anAsynchronousCall to: aComponent on: aCanvas [

	self subclassResponsibility
]

{ #category : #registering }
TriggeringPolicy >> deregister: aRegisteredTrigger from: aTriggerSystem [

	self subclassResponsibility 
]

{ #category : #registering }
TriggeringPolicy >> register: aTrigger to: aTriggerSystem [

	self subclassResponsibility 
]
