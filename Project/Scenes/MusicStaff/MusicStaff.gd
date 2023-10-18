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

func _ready():
	print("ready got called")
	screenX = get_viewport_rect().size.x
	screenY = get_viewport_rect().size.y
	startX = 0
	startY = 0
	
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
		lineThickness * 1.5)
	draw_line(
		Vector2(startX + screenX * staffLength,startY - 2.5 ), 
		Vector2(startX + screenX * staffLength, y - lineHeight * screenY + 2.2), 
		Color.BLACK, 
		lineThickness * 1.5)
	playBar.draw_line(
		Vector2(startX, startY),
		Vector2(startX, y),
		Color.BLACK,
		lineThickness * 3
	)
	
func getLineHeight() -> float:
	return self.screenY * lineHeight
	


func _on_play_button_pressed():
	playBar.play()
