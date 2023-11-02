class_name TutorialLevel extends Node2D

var bySharps = true
var notes = ["c4", "c4", "c4", "c4"]
var detunedAmountsList  = [0,0,-40,0]
var bpm = 100

func getNotes():
	print("got notes")
	return self.notes

func getBySharps():
	print("got by sharp")
	return self.bySharps
