extends Node2D

@onready var level1 = $Level1
func _ready():
	GLevelData.prevScene = "res://Scenes/Tutorial/tutorialScreen.tscn"
	level1.grab_focus()

func _on_return_button_pressed():
	SceneTransition.change_scene("res://Scenes/menuScreen.tscn")


func _on_next_button_pressed():
	SceneTransition.change_scene("res://Scenes/Tutorial/tutorialScreen2.tscn")
