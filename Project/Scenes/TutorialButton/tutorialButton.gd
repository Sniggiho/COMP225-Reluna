extends Button

@export var tutorialNum : String
var tut : TutorialLevel

func _ready():
	tut = GTutorialMenu.tutMenu[int(tutorialNum)]
	
func _on_pressed():
	GLevelData.tutorial = true
	GLevelData.bySharps = tut.bySharps
	GLevelData.notes = tut.notes
	GLevelData.detunedAmountsList = tut.detunedAmountsList
	GLevelData.bpm = tut.bpm
	GLevelData.numAccidentals = tut.numAccidentals
	GLevelData.numNotes = len(tut.notes)
	GLevelData.displayText = tut.displayText
	
	GLevelData.currentTut = int(tutorialNum)

	SceneTransition.change_scene("res://Scenes/firstScene.tscn")
	
	GLevelData.printValues()


func _on_mouse_entered():
	grab_focus()
