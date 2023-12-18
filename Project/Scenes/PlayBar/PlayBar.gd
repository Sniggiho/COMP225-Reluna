extends Line2D
class_name PlayBar

@export var path : Path2D
@onready var pathFollow : PathFollow2D = path.get_child(0)

## if the playbar is currently playing
var playing : bool = false

## the bpm at whoch to play notes
var bpm : float

## the number of notes in the level - used with bpm to determine playbar speed
var numNotes : int

## How many seconds the melody should last. Determined as: (numNotes + 1) * 60 / bpm / (1 - pregap)
var melodyLengthT : float = (6)*60/120.0/0.8

## Sets numNotes and bpm, and calculates and sets melodyLengthT 
func setNotesBPM(numNotes : int, bpm : float) -> void:
	self.numNotes = numNotes
	self.bpm = bpm
	self.melodyLengthT = (numNotes + 1) * 60. / bpm / 0.8

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# If playing is true, move the playbar
func _process(delta):
	if playing:
		pathFollow.progress_ratio += (1.0 / melodyLengthT) * delta
		global_position.x = pathFollow.global_position.x
		
		if pathFollow.progress_ratio >= 1:
			_reset()

# Reset position of play bar, set invisible, make it stop playing
func _reset() -> void:
	playing = false
	visible = false
	pathFollow.progress_ratio = 0
	global_position = pathFollow.global_position

## Reset things and beging playing
func play() -> void:
	if not playing:
		pathFollow.progress_ratio = 0
		visible = true
		playing = true
