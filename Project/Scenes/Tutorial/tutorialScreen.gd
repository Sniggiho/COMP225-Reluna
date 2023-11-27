extends Node2D

@onready var level1 = $Level1
func _ready():
	GLevelData.prevScene = "res://Scenes/Tutorial/tutorialScreen.tscn"
	level1.grab_focus()

## change to menu screen when the escape button is hit
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene("res://Scenes/menuScreen.tscn")
		
func _on_return_button_pressed():
	SceneTransition.change_scene("res://Scenes/menuScreen.tscn")


func _on_next_button_pressed():
	SceneTransition.change_scene("res://Scenes/Tutorial/tutorialScreen2.tscn")
