extends Node2D

func _on_return_button_pressed():
	SceneTransition.change_scene("res://Scenes/menuScreen.tscn")


func _on_next_button_pressed():
	SceneTransition.change_scene("res://Scenes/tutorialScreen2.tscn")
