generate machine code
concretizeFill32
	"fill with operand 0 according to the processor's endianness"
	self machineCodeAt: 0 put: (operands at: 0).
	^machineCodeSize := 4