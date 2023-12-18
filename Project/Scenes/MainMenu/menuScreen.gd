extends Node2D

@onready var tutorial = $Tutorial

func _input(event):
	if event.is_action_pressed('ui_left') or event.is_action_pressed('ui_right') or event.is_action_pressed('ui_down') or event.is_action_pressed('ui_up'):
		tutorial.grab_focus()
		
func _to_tutorial():
	SceneTransition.change_scene("res://Scenes/TutorialMenu/tutorialScreen.tscn")
	
func _to_freeplay():
	SceneTransition.change_scene("res://Scenes/FreeplaySettingsMenu/FreeplaySettingsMenu.tscn")
	
func _to_credits():
	SceneTransition.change_scene("res://Scenes/CreditScreen/CreditScreen.tscn")
