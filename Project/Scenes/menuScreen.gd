extends Node2D

@onready var playButton = $PlayButton

func _ready():
	pass
	
	
func _input(event):
	if event.is_action_pressed('ui_left') or event.is_action_pressed('ui_right') or event.is_action_pressed('ui_down') or event.is_action_pressed('ui_up'):
		playButton.grab_focus()
		
func _on_menu_button_pressed():
	SceneTransition.change_scene("res://Scenes/Tutorial/tutorialScreen.tscn")
	

