extends Node2D

func _ready():
	GLevelData.prevScene = "res://Scenes/Tutorial/tutorialScreen2.tscn"

func _on_return_button_pressed():
	SceneTransition.change_scene("res://Scenes/Tutorial/tutorialScreen.tscn")
