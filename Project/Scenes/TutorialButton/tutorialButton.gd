extends Button

@export var tutorialNum : String
var tutorial : Object

func _ready():
	tutorial = load("res://Tutorials/tutorial" + tutorialNum + ".gd") # resource is loaded at compile time
	
func _on_pressed():
	var tut = tutorial.new()
	GLevelData.tutorial = true
	GLevelData.bySharps = tut.bySharps
	GLevelData.notes = tut.notes
	GLevelData.detunedAmountsList = tut.detunedAmountsList
	GLevelData.bpm = tut.bpm
	GLevelData.numNotes = len(tut.notes)
	
	SceneTransition.change_scene("res://Scenes/firstScene.tscn")
	
	GLevelData.printValues()
