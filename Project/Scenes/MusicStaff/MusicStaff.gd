extends Node2D
class_name MusicStaff

# creates the actual visualization of the music staff and 
# notes on the screen. Connects callbacks with TuneCreator
# to allow for user interaction

# width of note, we need this for spacing out notes and 
# ledger lines
var noteWidth = 0
# scaling factor based on size of screen
@export var lineHeight = 0.07
@export var staffLength = 0.90
@export var lineThickness = 5.0
# size of screen
var screenX
var screenY 
# top left most position of staff
var startX 
var startY
var trebleRatio

@onready var playBar : PlayBar = $PlayBar
@onready var path : Path2D = $Path2D

func setNotesBPM(numNotes : int, bpm : float) -> void:
	playBar.setNotesBPM(numNotes, bpm)

func _ready():
	screenX = get_viewport_rect().size.x
	screenY = get_viewport_rect().size.y
	startX = 0
	startY = 0
	
	if not GLevelData.bySharps:
		for i in range(1,GLevelData.numAccidentals+1):
			get_node("sharp" + str(i)).show()  
	else:
		for i in range(1,GLevelData.numAccidentals+1):
			get_node("flat" + str(i)).show()  
func _draw():
	var y = startY
	for i in range(5):
		draw_line(
			Vector2(startX, y), 
			Vector2(startX + screenX * staffLength, y), 
			Color.BLACK, 
			lineThickness)
			
		y = y + screenY * lineHeight
		pass
	draw_line(
		Vector2(startX, startY - 2.5), 
		Vector2(startX, y - lineHeight * screenY + 2.2), 
		Color.BLACK, 
		lineThickness * 1.5
	)
	draw_line(
		Vector2(startX + screenX * staffLength,startY - 2.5 ), 
		Vector2(startX + screenX * staffLength, y - lineHeight * screenY + 2.2), 
		Color.BLACK, 
		lineThickness * 1.5
	)
	
	# changing the size of the playbar
	var h = (y - lineHeight * screenY + 2.2) - (startY)
	playBar.points[0] = Vector2(startX, -h/2 + 32)
	playBar.points[1] = Vector2(startX, h/2 + 32)
	playBar.width = lineThickness * 1.5

	
func getLineHeight() -> float:
	return self.screenY * lineHeight
	



