extends Polygon2D
class_name PlayBar

@export var path : Path2D
@onready var pathFollow : PathFollow2D = path.get_child(0)

var playing : bool = false

var melodyLengthT : float = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing:
		pathFollow.progress_ratio += (1.0 / melodyLengthT) * delta
		global_position.x = pathFollow.global_position.x
		
		if pathFollow.progress_ratio > 1:
			playing = false
		pass
	pass


func play() -> void:
	pathFollow.progress_ratio = 0
	playing = true
	pass
