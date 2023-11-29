extends Window
var attempts
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene("res://Scenes/firstScene.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_check_button_pressed():
	show()


func _on_return_button_pressed():
	hide()
	



func _on_next_button_pressed():
	hide()
