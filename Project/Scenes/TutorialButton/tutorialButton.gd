extends Button

@export var tutorialNum : String
var tut : TutorialLevel

func _ready():
	tut = GTutorialMenu.tutMenu[int(tutorialNum)]
	if int(tutorialNum) in GLevelData.completedTuts:
		self.get_child(0).show() # if GLevelData thinks we've done this, show the checkmark
		

## When pressed loads data from self.tut into GLevelData and transitions to the game scene as a tutorial
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

	SceneTransition.change_scene("res://Scenes/GameScene/firstScene.tscn")

func _on_mouse_entered():
	grab_focus()
