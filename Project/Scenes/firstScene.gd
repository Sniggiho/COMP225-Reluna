extends Node2D

@onready var playButton = $PlayButton
@onready var returnButton = $ReturnButton
@onready var hintButton = $HintButton
@onready var checkButton = $CheckButton 
@onready var middleNote = len(GLevelData.notes) / 2
@onready var currNote = middleNote
@onready var notes = $LevelManager.getTuneCreator().getListOfNotes()
var attempts
var firstFocused = false
func _ready():
	#give focus to the middle note
	playButton.focus_neighbor_top = playButton.get_path_to(returnButton)
	returnButton.focus_neighbor_bottom = returnButton.get_path_to(playButton)
	
	
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

	

func navigateBetweenNotes(event) -> void:
	## set left and right neighbor
	## if they are out of bounds of the note array
	## make sure that the focus does not change
	#if focus is on the music bar
	if !playButton.has_focus() and !returnButton.has_focus() and !hintButton.has_focus() and !checkButton.has_focus():
		if event.is_action_pressed("ui_left") and currNote != 0:
			#update currNote and give focus to it
			currNote = currNote - 1
			notes[currNote].get_node('Button').grab_focus()
			print(notes[currNote].get_node('Button').grab_focus())
		# check for being at the right bound
		if event.is_action_pressed("ui_right") and currNote != len(notes)-1:
			#update currNote and give focus to it
			currNote = currNote + 1
			notes[currNote].get_node('Button').grab_focus()
			print(notes[currNote].get_node('Button').grab_focus())
		if event.is_action_pressed("ui_up"):
			returnButton.grab_focus()
		if event.is_action_pressed("ui_down"):
			playButton.grab_focus()

