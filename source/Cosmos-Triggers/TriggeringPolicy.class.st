Class {
	#name : #TriggeringPolicy,
	#superclass : #Object,
	#category : #'Cosmos-Triggers-Model'
}

{ #category : #registering }
TriggeringPolicy >> deregister: aRegisteredTrigger from: aTriggerSystem [

	self subclassResponsibility 
]

{ #category : #registering }
TriggeringPolicy >> register: aTrigger to: aTriggerSystem [

	self subclassResponsibility 
]
