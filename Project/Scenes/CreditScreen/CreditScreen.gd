extends Node2D


func _input(event):
	if event.is_action_pressed('ui_left') or event.is_action_pressed('ui_right') or event.is_action_pressed('ui_down') or event.is_action_pressed('ui_up'):
		$Return.grab_focus()
	if event.is_action_pressed("ui_cancel"):
		_to_main_menu()
		

func _to_main_menu():
	SceneTransition.change_scene("res://Scenes/MainMenu/menuScreen.tscn")
