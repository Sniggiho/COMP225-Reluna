extends Node2D

# whether or not gleveldata has been set
var valid : bool = false

var tutorial : bool # true for tutorials, false for freeplay

# shared settings
var bySharps : bool
var bpm : int
var numAccidentals : int
var prevScene : String

var displayText : String = "Display text didn't get set..."

# free play settings
var lowestNote : String
var highestNote : String
var numDetunedNotes : int
var detuneDir : int # -1 for flat only, 0 for both, 1 for sharp only
var maxDetuneCents : int
var minDetuneCents : int
var numNotes : int

# tutorial settings
var notes : Array
var detunedAmountsList : Array
var currentTut : int
var completedTuts : Array = []

# Debugger function printing all internal variables
func printValues():
	print("tutorial:", tutorial)

	# shared settings
	print("bySharps:",bySharps)
	print("bpm:",bpm)
	print("numAccidentals:",numAccidentals)

	# free play settings
	if not tutorial:
		print("lowestNote:", lowestNote)
		print("highestNote:", highestNote)
		print("numDetunedNotes:", numDetunedNotes)
		print("detuneDir:", detuneDir)
		print("maxDetuneCents:", maxDetuneCents)
		print("minDetuneCents:", minDetuneCents)
		print("numNotes:", numNotes)
	else:
		# tutorial settings
		print("notes:",notes)
		print("detunedAmountsList:", detunedAmountsList)
		print("completedTuts:", completedTuts)
		print("currentTut:", currentTut)
		
