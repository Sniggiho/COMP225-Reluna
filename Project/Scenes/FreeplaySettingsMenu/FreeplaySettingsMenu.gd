extends Node2D
class_name FreeplaySettingsMenu

func _ready():
	# What a fucking mess
	$ForwardButton.focus_neighbor_bottom = $ForwardButton.get_path_to($"CenterContainer/VBoxContainer/CenterContainer/HBoxContainer/Column B/ColumnB/NumNotes")
	
	#$ForwardButton.grab_focus()
	
#	$"CenterContainer/VBoxContainer/CenterContainer/HBoxContainer/Column B/ColumnB/NumNotes".focus_neighbor_top = $"CenterContainer/VBoxContainer/CenterContainer/HBoxContainer/Column B/ColumnB/NumNotes".get_path_to($"ForwardButton")
	
	$BackButton.focus_neighbor_bottom = $BackButton.get_path_to($"CenterContainer/VBoxContainer/CenterContainer/HBoxContainer/Column A/ColumnA/Accidental Choice/BySharps".getSharpButton())


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_goto_main_menu()
	if event.is_action_pressed('ui_left') or event.is_action_pressed('ui_right') or event.is_action_pressed('ui_down') or event.is_action_pressed('ui_up'):
		$ForwardButton.grab_focus()
		



func _on_button_pressed():
	GLevelData.tutorial = false
	GLevelData.prevScene = "res://Scenes/FreeplaySettingsMenu/FreeplaySettingsMenu.tscn"
	GLevelData.valid = true
	SceneTransition.change_scene("res://Scenes/GameScene/firstScene.tscn")
	

func _goto_main_menu():
	GLevelData.valid = false
	SceneTransition.change_scene("res://Scenes/MainMenu/menuScreen.tscn")
