extends Node2D
## First Tutural Level screen
## level 1 to 12

## first level on this screen
@onready var level1 = $Level1

## loads in scene first time entering the scene tree
func _ready():
	GLevelData.prevScene = "res://Scenes/TutorialMenu/tutorialScreen.tscn"
	level1.grab_focus()

## "esc" returns back to menu screen
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_return_button_pressed()

## returns to menu screen
func _on_return_button_pressed():
	SceneTransition.change_scene("res://Scenes/MainMenu/menuScreen.tscn")

## changes to tutorial screen 2
func _on_next_button_pressed():
	SceneTransition.change_scene("res://Scenes/TutorialMenu/tutorialScreen2.tscn")
