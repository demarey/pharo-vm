bytecode generators
genSend: selector numArgs: numArgs sendTable: sendTable
	<inline: false>
	<var: #sendTable type: #'sqInt *'>
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	self assert: needsFrame.
	self assert: (numArgs between: 0 and: 256). "say"
	self assert: (objectMemory addressCouldBeOop: selector).
	self MoveMw: numArgs * objectMemory wordSize r: SPReg R: ReceiverResultReg.
	numArgs > 2 ifTrue:
		[self MoveCq: numArgs R: SendNumArgsReg].
	self MoveCw: selector R: ClassReg.
	self CallSend: (sendTable at: (numArgs min: NumSendTrampolines - 1)).
	self flag: 'currently caller pushes result'.
	self PushR: ReceiverResultReg.
	^0