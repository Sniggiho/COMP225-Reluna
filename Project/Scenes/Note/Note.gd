extends Node2D
class_name Note

@export var detuneCents := 0 # the number of cents out of tune 
@export var noteName := "c3" # default note is c3

@onready var sprite : Sprite2D = $Button/Sprite2D

@export var defaultColor : Color = Color("000000")
@export var selectedColor : Color = Color("e24c59")

var selected : bool = false

var lineHeight : float


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = defaultColor
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func centsToRatio(cents) -> float:
	return pow(2, cents/1200.0)

func setNoteByName(note: String) -> void:
	note.strip_escapes()
	note.to_lower()
	noteName = note
	
func getNoteName() -> String:
	return noteName
	
func setDetuneCents(cents) -> void:
	detuneCents = cents
	
func getDetuneCents() -> int:
	return detuneCents

func orientation() -> void:
	_draw()
	if(noteName[-1] > "4"):
		var sprite = $Button/Sprite2D
		sprite.set_flip_h(true)
		sprite.set_flip_v(true)
		var height = sprite.texture.get_height()
		sprite.set_offset(Vector2(0,height*0.55))
		

func _draw():
	createLedgerLines()
	pass
		
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

func select() -> void:
	selected = !selected
	_changeColor()
	
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
	print("bySharps: ", get_parent().getBySharps())
	print("length NoteName: ", len(noteName))
	if not get_parent().getBySharps() and len(noteName) == 3:
		noteVal += 1
	return octave + noteVal
	
