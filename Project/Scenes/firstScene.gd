extends Node2D

@onready var playButton = $PlayButton
var attempts
var firstFocused = false
func _ready():
	playButton.grab_focus()
	
## change to previous scene when escape button is hit
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene(GLevelData.prevScene)
	
func _on_play_button_pressed():
	$MusicStaff.playBar.play()
func numAttempts() -> int:
	
	return 1

