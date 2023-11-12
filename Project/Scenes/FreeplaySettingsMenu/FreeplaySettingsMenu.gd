extends Node2D
class_name FreeplaySettingsMenu

@export var DetuneDirection : ItemList
@export var NumNotes : Slider
@export var NumDetuned : Slider
@export var MaxDetuneCents : Slider
@export var MinDetuneCents : Slider
@export var MinNote : Slider
@export var MaxNote : Slider

func generatePossibleNotes() -> Array:
	var noteOrder = ["c","c-","d","d-","e","f","f-","g","g-","a","a-","b"]
	var possibleNotes = []
	for i in range(3,6):
		for n in noteOrder:
			var noteName = n + str(i)
			possibleNotes.append(noteName)
	
	possibleNotes.append("c6")
	return possibleNotes


func _ready():
	if GLevelData.valid:
#		DetuneDirection.select(1)
#		NumNotes.value = GLevelData.numNotes
#		NumDetuned.value = GLevelData.numDetunedNotes
#		MaxDetuneCents.value = GLevelData.maxDetuneCents
#		MinDetuneCents.value = GLevelData.minDetuneCents
		pass

func _on_button_pressed():
	GLevelData.tutorial = false
	GLevelData.bpm = 120
	GLevelData.prevScene = "res://Scenes/FreeplaySettingsMenu/FreeplaySettingsMenu.tscn"
	GLevelData.valid = true
	SceneTransition.change_scene("res://Scenes/firstScene.tscn")
