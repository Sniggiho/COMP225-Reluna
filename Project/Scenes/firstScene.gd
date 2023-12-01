extends Node2D

@onready var playButton = $PlayButton
@onready var returnButton = $ReturnButton
@onready var hintButton = $HintButton
@onready var checkButton = $CheckButton 
@onready var middleNote = len(GLevelData.notes) / 2
@onready var notes = $LevelManager.getTuneCreator().getListOfNotes()
var attempts
var firstFocused = false
func _ready():
	setUpFocusNeighbors()
	
## change to previous scene when escape button is hit
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene(GLevelData.prevScene)
	if firstFocused == false and (event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down")):
		firstFocused = true
		playButton.grab_focus()	
	
func _on_play_button_pressed():
	$MusicStaff.playBar.play()
	
func numAttempts() -> int:
	return 1

func setUpFocusNeighbors() -> void: 
	playButton.focus_neighbor_top = playButton.get_path_to(notes[middleNote].get_node("Button"))
	notes[middleNote].get_node("Button").focus_neighbor_bottom = notes[middleNote].get_node("Button").get_path_to(playButton)
	returnButton.focus_neighbor_bottom = returnButton.get_path_to(notes[middleNote].get_node("Button"))
	for i in len(notes) - 1:
		notes[i].get_node("Button").focus_neighbor_right = notes[i].get_node("Button").get_path_to(notes[i+1].get_node("Button"))
	for i in range(1, len(notes)):
		notes[i].get_node("Button").focus_neighbor_left = notes[i].get_node("Button").get_path_to(notes[i-1].get_node("Button"))
	for i in len(notes):
		notes[i].get_node("Button").focus_neighbor_top = notes[i].get_node("Button").get_path_to(returnButton)
		notes[i].get_node("Button").focus_neighbor_bottom = notes[i].get_node("Button").get_path_to(playButton)

