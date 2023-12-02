extends Node2D
class_name FreeplaySettingsMenu

func _ready():
	# What a fucking mess
	$ForwardButton.focus_neighbor_bottom = $ForwardButton.get_path_to($"CenterContainer/VBoxContainer/CenterContainer/HBoxContainer/Column B/ColumnB/DetuneDirection/DetuneDirection".getFlatButton())
	
	$BackButton.focus_neighbor_bottom = $BackButton.get_path_to($"CenterContainer/VBoxContainer/CenterContainer/HBoxContainer/Column A/ColumnA/Accidental Choice/BySharps".getSharpButton())

func generatePossibleNotes() -> Array:
	var noteOrder = ["c","c-","d","d-","e","f","f-","g","g-","a","a-","b"]
	var possibleNotes = []
	for i in range(3,6):
		for n in noteOrder:
			var noteName = n + str(i)
			possibleNotes.append(noteName)
	
	possibleNotes.append("c6")
	return possibleNotes


func _on_button_pressed():
	GLevelData.tutorial = false
	GLevelData.prevScene = "res://Scenes/FreeplaySettingsMenu/FreeplaySettingsMenu.tscn"
	GLevelData.valid = true
	SceneTransition.change_scene("res://Scenes/firstScene.tscn")
	

func _goto_main_menu():
	GLevelData.valid = false
	SceneTransition.change_scene("res://Scenes/menuScreen.tscn")
	pass
