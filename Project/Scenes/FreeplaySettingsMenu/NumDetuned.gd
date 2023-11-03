extends HSlider

var numNotes = GLevelData.numNotes

var text : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	text = RichTextLabel.new()
	text.size = Vector2(100, 100)
	text.position = Vector2(-30, -30)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(text)
	min_value = 1
	value = min_value
	max_value = 3
	tick_count = int(max_value - min_value + 1)


# SIGNAL PASSED HERE FROM NUM NOTES
# Listens to whenver NumNotes slider changes
#
# Makes sure that the max value of detuned notes is one less than the 
# number of notes
#
# (We can't have every note be out of tune)
func _on_num_notes_value_changed(passedValue):
	max_value = passedValue-1
	tick_count = int(max_value - min_value + 1)


# SIGNAL FROM SELF
# Whenver this objects value is changed, update the text and GLevelData
func _on_value_changed(passedValue):
	text.text = str(passedValue)
	GLevelData.numDetunedNotes = passedValue


# SIGNAL PASSED HERE FROM NUM NOTES
#
# Only change the value of this with respect to its new max value 
# once the drag is done.
#
# If the user had 8 detuned notes and 13 notes and they dragged num notes below
# 9, then the detuned number is instantly changed. Now, detuned notes 
# will only be changed if the *final* release of num notes violates the bounds. 
func _on_num_notes_drag_ended(value_changed):
	if value_changed and value > max_value:
		value = max_value
