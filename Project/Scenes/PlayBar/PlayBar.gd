extends Line2D
class_name PlayBar

@export var path : Path2D
@onready var pathFollow : PathFollow2D = path.get_child(0)

var playing : bool = false

var melodyLengthT : float = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing:
		pathFollow.progress_ratio += (1.0 / melodyLengthT) * delta
		global_position.x = pathFollow.global_position.x
		
		if pathFollow.progress_ratio >= 1:
			_reset()
		pass
	pass

# Reset position of play bar, set invisible, make it stop playing
func _reset() -> void:
	playing = false
	visible = false
	pathFollow.progress_ratio = 0
	global_position = pathFollow.global_position
	pass

func play() -> void:
	if not playing:
		pathFollow.progress_ratio = 0
		visible = true
		playing = true
