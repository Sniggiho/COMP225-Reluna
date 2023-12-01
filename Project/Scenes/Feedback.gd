extends Window
var attempts
@onready var returnButton = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/ReturnButton
@onready var nextButton = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/NextButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene("res://Scenes/firstScene.tscn")
	if returnButton.visible and (event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up")):
		returnButton.grab_focus()
	if nextButton.visible and (event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up")):
		nextButton.grab_focus()
	if returnButton.has_focus() and event.is_action_pressed("ui_accept"):
		hide()
	if nextButton.has_focus() and event.is_action_pressed("ui_accept"):
		hide()
		get_node("../LevelManager")._reset()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_check_button_pressed():
	show()


func _on_return_button_pressed():
	hide()
	

func _on_next_button_pressed():
	hide()
