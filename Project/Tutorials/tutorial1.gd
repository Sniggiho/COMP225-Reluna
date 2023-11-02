class_name TutorialLevel extends Node2D

var bySharps = true
var notes = ["C4", "C4", "C4", "C4"]
var detunedAmountsList  = [0,0,-40,0]
var bpm = 60

func getNotes():
	print("got notes")
	return self.notes

func getBySharps():
	print("got by sharp")
	return self.bySharps
