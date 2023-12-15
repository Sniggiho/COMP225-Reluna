class_name TutorialLevel extends Node2D

var bySharps : bool
var notes : Array
var detunedAmountsList : Array
var bpm : int
var numAccidentals : int
var displayText : String

func setup(bySharps, notes, detunedAmountsList,bpm,numAccidentals,displayText) -> void:
	self.bySharps = bySharps
	self.notes = notes
	self.detunedAmountsList = detunedAmountsList
	self.bpm = bpm
	self.numAccidentals = numAccidentals
	self.displayText = displayText
