@tool
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

## set the BPM
func setNotesBPM(numNotes : int, bpm : float) -> void:
	playBar.setNotesBPM(numNotes, bpm)

## load in the first time enters the scene tree
func _ready():
	screenX = get_viewport_rect().size.x
	screenY = get_viewport_rect().size.y
	startX = 0
	startY = 0
	var lastAccidental : Sprite2D
	
	if GLevelData.bySharps:
		for i in range(1,GLevelData.numAccidentals+1):
			get_node("sharp" + str(i)).show()
		lastAccidental = get_node("sharp" + str(GLevelData.numAccidentals))
	else:
		for i in range(1,GLevelData.numAccidentals+1):
			get_node("flat" + str(i)).show()
		print( get_node("flat" + str(GLevelData.numAccidentals)))
		lastAccidental = get_node("flat" + str(GLevelData.numAccidentals))
	
	var xBuffer = 0
	if GLevelData.numAccidentals == 0:
		xBuffer = get_node("flat1").position.x - get_node("flat1").texture.get_width()*get_node("flat1").scale.x/2
	else:
		xBuffer = lastAccidental.position.x + lastAccidental.texture.get_width()*lastAccidental.scale.x/2

	self.get_child(1).get_curve().set_point_position(0,Vector2(xBuffer,0))

## draws the music staff
func _draw():
	var y = startY
	for i in range(5):
		draw_line(
			Vector2(startX, y), 
			Vector2(startX + screenX * staffLength, y), 
			Color.BLACK, 
			lineThickness)
			
		y = y + screenY * lineHeight
			
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

## getter method for the line height
func getLineHeight() -> float:
	return self.screenY * lineHeight
	


func _on_play_button_pressed():
	playBar.play()
