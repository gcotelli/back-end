private
handleMessage: aMQTTPublish

	rules keys
		detect: [ :rx | rx matches: aMQTTPublish topic ]
		ifFound: [ :rx | rx matchesIn: aMQTTPublish topic subexpressionsDo: [ :topic :subexpressions | (rules at: rx) value: topic value: aMQTTPublish message value: subexpressions ] ]