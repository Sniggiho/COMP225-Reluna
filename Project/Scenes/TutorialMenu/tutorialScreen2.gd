extends Node2D
## Second Tutorial Level screen
## Levels 13 to 24

## first level on this screen
@onready var level13 = $Level13

## loads in when the scene first enters the scene tree
func _ready():
	GLevelData.prevScene = "res://Scenes/TutorialMenu/tutorialScreen2.tscn"
	level13.grab_focus()

## change to menu screen when the escape button is hit
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_return_button_pressed()

## changes to the previous tutorial screen
func _on_return_button_pressed():
	SceneTransition.change_scene("res://Scenes/TutorialMenu/tutorialScreen.tscn")
