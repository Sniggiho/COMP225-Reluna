extends Node2D
## Main Scene that users interact with 
## play a chain of notes and select the out of tune ones
## interact with notes and other buttons
## move on to next level or back to tutorial levels

## play button
@onready var playButton : TextureButton = $PlayButton

## return button
@onready var returnButton : TextureButton = $ReturnButton

## TODO: hint button
@onready var hintButton : TextureButton = $HintButton

## button that checks our answers
@onready var checkButton : TextureButton = $CheckButton 

## the most centered note, use this for button navigation
@onready var middleNote : int = len(GLevelData.notes) / 2

## array of notes
@onready var notes : Array = $LevelManager.getTuneCreator().getListOfNotes()

## if the any elements are focused on the screen
var firstFocused : bool = false

## load in the scene when it first enters the scene tree
func _ready():
	setUpFocusNeighbors()

## takes in keyboard inputs 
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene(GLevelData.prevScene)
	if firstFocused == false and (event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down")):
		firstFocused = true
		playButton.grab_focus()	
	if event.is_action_pressed("play"):
		$MusicStaff.playBar.play()
		
		
func _process(delta):
	var numSelected = 0
	for i in notes:
		if i.selected:
			numSelected = numSelected + 1
	if numSelected > 0:
		for i in notes: 
			i.get_node("Button").focus_neighbor_bottom = i.get_node("Button").get_path_to(checkButton)
	else: 
		for i in notes: 
			i.get_node("Button").focus_neighbor_bottom = i.get_node("Button").get_path_to(playButton)

## play the notes when the playbar is pressed
func _on_play_button_pressed() -> void:
	$MusicStaff.playBar.play()

## set up the connections between all the interactable buttons
func setUpFocusNeighbors() -> void: 
	notes = $LevelManager.getTuneCreator().getListOfNotes()
	playButton.focus_neighbor_top = playButton.get_path_to(notes[middleNote].get_node("Button"))
	checkButton.focus_neighbor_top = checkButton.get_path_to(notes[middleNote].get_node("Button"))
	hintButton.focus_neighbor_top = hintButton.get_path_to(notes[middleNote].get_node("Button"))
	notes[middleNote].get_node("Button").focus_neighbor_bottom = notes[middleNote].get_node("Button").get_path_to(playButton)
	returnButton.focus_neighbor_bottom = returnButton.get_path_to(notes[middleNote].get_node("Button"))
	for i in len(notes) - 1:
		notes[i].get_node("Button").focus_neighbor_right = notes[i].get_node("Button").get_path_to(notes[i+1].get_node("Button"))
	for i in range(1, len(notes)):
		notes[i].get_node("Button").focus_neighbor_left = notes[i].get_node("Button").get_path_to(notes[i-1].get_node("Button"))
	for i in len(notes):
		notes[i].get_node("Button").focus_neighbor_top = notes[i].get_node("Button").get_path_to(returnButton)
		notes[i].get_node("Button").focus_neighbor_bottom = notes[i].get_node("Button").get_path_to(playButton)



