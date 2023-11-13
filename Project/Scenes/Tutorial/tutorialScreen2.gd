extends Node2D

@onready var level13 = $Level13
func _ready():
	GLevelData.prevScene = "res://Scenes/Tutorial/tutorialScreen2.tscn"
	level13.grab_focus()

func _on_return_button_pressed():
	SceneTransition.change_scene("res://Scenes/Tutorial/tutorialScreen.tscn")
