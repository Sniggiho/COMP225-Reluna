extends Node2D

@onready var playButton = $PlayButton
var attempts
func _ready():
	playButton.grab_focus()
	
func _on_play_button_pressed():
	$MusicStaff.playBar.play()

func numAttempts() -> int:
	
	return 1

