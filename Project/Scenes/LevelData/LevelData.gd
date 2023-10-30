extends Node2D

@export var noteSet : Array
@export var bySharps : bool
@export var detunedAmounts : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getNoteSet() -> Array:
	return self.noteSet
	
func getBySharps() -> bool:
	return self.bySharps

func getDetunedAmounts() -> Array:
	return self.detunedAmounts
