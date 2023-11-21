extends VSlider

var text : RichTextLabel = RichTextLabel.new()

var notes : Array = ["c3", "c-3", "d3", "d-3", "e3", "f3", "f-3", "g3", "g-3", "a3", "a-3", "b3", 
					 "c4", "c-4", "d4", "d-4", "e4", "f4", "f-4", "g4", "g-4", "a4", "a-4", "b4", 
					 "c5", "c-5", "d5", "d-5", "e5", "f5", "f-5", "g5", "g-5", "a5", "a-5", "b5", 
					 "c6", "c-6"]
					
var noteMinIndex : int = 9
var noteMaxIndex : int = 36

var currNoteMin : int = 9

# Called when the node enters the scene tree for the first time.
func _ready():
	min_value = noteMinIndex
	max_value = noteMaxIndex
	
#	if GLevelData.valid:
#		value = notes.find(GLevelData.highestNote)
#	else:
	value = max_value
		
	
	text.text = notes[value]
	text.position = Vector2(-20, -20)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	text.size = Vector2(100, 100)
	add_child(text)
	
	GLevelData.highestNote = notes[value+1]
	
	print("GLevelData's highest note: ", GLevelData.highestNote)
	
#	var numTicks : int = noteMaxIndex - noteMinIndex + 1
#	tick_count = numTicks
	

# PASSED FROM SELF
func _on_value_changed(passedValue):
	if passedValue < currNoteMin:
		value = currNoteMin
	text.text = notes[value]
	GLevelData.highestNote = notes[value+1]
	print("GLevelData's higherst note: ", GLevelData.highestNote)


# PASSED FROM MIN NOTE
func _on_min_note_value_changed(passedValue):
	currNoteMin = passedValue
