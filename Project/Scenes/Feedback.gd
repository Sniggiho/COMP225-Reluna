extends Window

## The Feedback screen is a pop up screen that gives you feedback
## on your performance and serves as the intermediary screen that 
## allows to either navigate back to the current level or advance
## to the next level

## return button
@onready var _returnButton = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/ReturnButton

## next button
@onready var _nextButton = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/NextButton

## controls button functionality of feedback screen
## "esc" allows for user to force quit and return to current level
## no focus on return and next button until use arrow keys
## "enter" will press the button
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene("res://Scenes/firstScene.tscn")
	if _returnButton.visible and (event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up")):
		_returnButton.grab_focus()
	if _nextButton.visible and (event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up")):
		_nextButton.grab_focus()
	if _returnButton.has_focus() and event.is_action_pressed("ui_accept"):
		hide()
	if _nextButton.has_focus() and event.is_action_pressed("ui_accept"):
		hide()
		get_node("../LevelManager")._reset()

## display feedback window when check button is pressed
func _on_check_button_pressed():
	show()

## exit out of feedback window when returning to current level
func _on_return_button_pressed():
	hide()

## exit out of feedback window when moving on to the next level
func _on_next_button_pressed():
	hide()
