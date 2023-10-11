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


func _ready():
	screenX = get_viewport_rect().size.x
	screenY = get_viewport_rect().size.y
	startX = screenX * ((1 - staffLength)/2.0)
	startY = screenY * 0.15 
	var treble = Image.load_from_file("res://Scenes/MusicStaff/trebleStaff.png")
	treble.set
	var texture = ImageTexture.create_from_image(treble)
	trebleRatio = 4 * lineHeight * screenY / treble.get_height()
	treble.resize(treble.get_width()*trebleRatio, treble.get_height()* trebleRatio, Image.INTERPOLATE_BILINEAR)
	$Sprite2D.texture = texture
	
func _draw():
	var y = startY
	for i in range(5):
		draw_line(Vector2(startX, y), Vector2(startX + screenX * staffLength, y), Color.BLACK, lineThickness)
		y = y + screenY * lineHeight
	draw_line(Vector2(startX, startY - 2.5), Vector2(startX, y - lineHeight * screenY + 2.2), Color.BLACK, lineThickness* 1.5)
	draw_line(Vector2(startX + screenX * staffLength,startY - 2.5 ), Vector2(startX + screenX * staffLength, y - lineHeight * screenY + 2.2), Color.BLACK, lineThickness * 1.5)
	
func getLineHeight() -> float:
	return screenY * lineHeight
	



