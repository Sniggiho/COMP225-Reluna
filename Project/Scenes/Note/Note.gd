extends Control
class_name Note
## Note class is an interactable note that encomposses all of
## the characteristics of a note including note name, note sound, 
## note color, note shape and size, ledger lines 

## number of cents detuned
@export var detuneCents := 0

## the note name, default is c3
@export var noteName := "c3"

## interactable note button
@onready var button : Button = $Button

## image of note
@onready var sprite : Sprite2D = $Button/Sprite2D

## image for selected ntoe
@onready var selectedSprite : Sprite2D = $Button/SelectedImage

## default color of the note
@export var defaultColor : Color = Color("000000")

## color of note when selected 
@export var selectedColor : Color = Color("e24c59")

## color of note when focused but not selected
@export var focusedColor : Color = Color("0bccf4")

## if object is selectable
var selectable : bool = true

## if the note is selected
var selected : bool = false

## timer
var timer : Timer

## Music staff's line gap 
var lineHeight : float

## error message for first note will always be in tune
var text : RichTextLabel

## if debugging of note labels is on
var noteLabelDebug : bool = false

## note label
var noteLabel : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = defaultColor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	focusedNote()

## "enter" to select currently focused notes
func _input(event):
	if self.has_focus() and event.is_action_pressed("ui_accept"):
		selected = ! selected

# conversion of cents
func centsToRatio(cents) -> float:
	return pow(2, cents/1200.0)

## assign note name
func setNoteByName(note: String) -> void:
	note.strip_escapes()
	note.to_lower()
	noteName = note

## getter method for the note name
func getNoteName() -> String:
	return noteName

## sets the detuned amount
func setDetuneCents(cents) -> void:
	detuneCents = cents

## getter method for detuned amount
func getDetuneCents() -> int:
	return detuneCents

## flips note up or down depending on position on the staff
func orientation() -> void:
	_draw()
	if(noteName[-1] > "4"):
		sprite.set_flip_h(true)
		sprite.set_flip_v(true)
		
		selectedSprite.set_flip_h(true)
		selectedSprite.set_flip_v(true)
		
		var height = sprite.texture.get_height()
		sprite.set_offset(Vector2(0,height*0.55))
		selectedSprite.set_offset(Vector2(0, height * 0.55))

## draw the ledger lines
func _draw():
	createLedgerLines()

## create ledger lines for the notes
func createLedgerLines() ->  void:
	if get_parent():
		var h : int = hOffset()
		
		# Debug to create text to label the offset
#		var label : RichTextLabel = RichTextLabel.new()
#		add_child(label)
#		label.text = str(h)
#		label.mouse_filter = Control.MOUSE_FILTER_IGNORE
#		label.size = Vector2(100, 100)
		
		# Color
		var color : Color = Color.BLACK
#		color = Color.CADET_BLUE # DEBUG

		# Ledger line length (horizontal)
		var length = 75
		
		# AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
		if h >= 5: # If above the staff
			if h % 2 == 0:
				h -= 6
				h /= 2
				for i in range(0, h+1, 1):
					draw_line(
						Vector2(-length/2.0, (1+2*i) * lineHeight / 2.0), 
						Vector2(length/2.0, (1+2*i) * lineHeight / 2.0), 
						color, 
						5
					)
			else:
				h -= 5
				h /= 2
				for i in range(0, h+1, 1):
					draw_line(
						Vector2(-length/2.0, 2*i * lineHeight / 2.0), 
						Vector2(length/2.0, 2*i * lineHeight / 2.0), 
						color, 
						5
					)
		elif h <= -7: # If below the staff
			h *= -1
			if h % 2 == 0:
				h -= 6
				h /= 2
				for i in range (0, h, 1):
					draw_line(
						Vector2(-length/2.0, (-1 - 2 * i) * lineHeight / 2.0),
						Vector2(length/2.0, (-1 - 2 * i) * lineHeight / 2.0),
						color,
						5
					)
			else:
				h -= 7
				h /= 2
				for i in range(0, h+1, 1):
					draw_line(
						Vector2(-length/2.0, -2 * i * lineHeight / 2.0),
						Vector2(length/2.0, -2 * i * lineHeight / 2.0),
						color,
						5
					)
			pass
	
	pass

## select the note and change color accordingly
func select() -> void:
	if selectable:
		selected = !selected
		_changeColor()
	else: # is first note
		if not text:
			text = RichTextLabel.new()
			text.text = "The first note will always be in-tune"
			text.size = Vector2(100, 100)
			text.mouse_filter = Control.MOUSE_FILTER_IGNORE
			add_child(text)
			
			_timerDeleteRoutine()
	
	if noteLabelDebug and not noteLabel:
		noteLabel = RichTextLabel.new()
		noteLabel.text = str(noteName, " ", detuneCents)
		noteLabel.size = Vector2(100, 100)
		noteLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		noteLabel.position = Vector2(-20, -20)
		add_child(noteLabel)
		
		_timerDeleteRoutine()

## check if note is focused and change color accordingly
func focusedNote() -> void: 
	if button.has_focus():
		selectedSprite.visible = true
	else: 
		selectedSprite.visible = false
		_changeColor()

# If timer doesn't exist, create it and set parameters
# Connect it to the function that deletes the texts and the timer itself
func _timerDeleteRoutine() -> void:
	if not timer:
		timer = Timer.new()
		timer.one_shot = true
		timer.autostart = true
		timer.wait_time = 2
		add_child(timer)
		timer.timeout.connect(_clearTexts)

# connected to timer if it exsits.
# Timer only exists for the first click of the first note
func _clearTexts() -> void:
	if text:
		text.queue_free()
	
	if noteLabel:
		noteLabel.queue_free()
	
	timer.queue_free()

## toggles color between selected and unselected notes
func _changeColor() -> void:
	if selected:
		sprite.modulate = selectedColor
	else:
		sprite.modulate = defaultColor
	pass

# return how much the note offset is 
func hOffset() -> int:
	## uses C for the off set just because that is what it starts with
	## dictionary for differences between notes
	var noteDict = {"c": 0, "d": 1, "e": 2, "f": 3, "g": 4, "a": 5, "b": 6 }
	## each octave will be 7 half note offsets
	var octave = (int(noteName[-1]) - 5) * 7
	## value based on the note
	var noteVal = noteDict[noteName[0]]
	if not get_parent().getBySharps() and len(noteName) == 3:
		noteVal += 1
	return octave + noteVal
