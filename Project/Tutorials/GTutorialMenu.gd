extends Node2D

var tut1 = TutorialLevel.new()
var tut2 = TutorialLevel.new()
var tut3 = TutorialLevel.new()
var tut4= TutorialLevel.new()
var tut5 = TutorialLevel.new()
var tut6 = TutorialLevel.new()
var tut7 = TutorialLevel.new()
var tut8 = TutorialLevel.new()
var tut9 = TutorialLevel.new()
var tut10 = TutorialLevel.new()
var tut11 = TutorialLevel.new()
var tut12 = TutorialLevel.new()

var tutMenu = {
	1: tut1,
	2: tut2,
	3: tut3,
	4: tut4,
	5: tut5,
	6: tut6,
	7: tut7,
	8: tut8,
	9: tut9,
	10: tut10,
	11: tut11,
	12: tut12
}

func _ready():
	# set up each tutorial
	tut1.setup(true, ["c4","c4","c4","c4"], [0,0,-40,0], 100, 0, "Select the one flat note")
	tut2.setup(true, ["c4","c4","c4","c4"], [0,40,0,0], 100, 0, "Select the one sharp note")
	tut3.setup(true, ["c4","d4","e4","f4", "g4"], [0,0,0,-40,0], 100, 0, "Select the one flat note")
	tut4.setup(true, ["c4","d4","e4","f4", "g4"], [0,0,0,0,40], 100, 0, "Select the one sharp note")
	tut5.setup(true, ["c4","e4","g4","e4", "c4"], [0,40,0,0,0], 100, 0, "Select the one sharp note")
	tut6.setup(true, ["c4","e4","g4","e4", "c4"], [0,0,-40,0,0], 100, 0, "Select the one flat note")
	tut7.setup(true, ["a4","b4","c5","d5", "e5"], [0,40,0,0,0], 100, 0, "Select the one sharp note")
	tut8.setup(true, ["a4","b4","c5","d5", "e5"], [0,0,0,0,-40], 100, 0, "Select the one flat note")
	tut9.setup(true, ["a4","c5","e5","a5"], [0,0,0,-40], 100, 0, "Select the one flat note")
	tut10.setup(true, ["a4","c5","e5","a5"], [0,40,0,0], 100, 0, "Select the one sharp note")
	tut11.setup(false, ["f5","e5","d5","c5"], [0,0,-40,0], 100, 1, "Select the one flat note")
	tut12.setup(false, ["f5","e5","d5","c5"], [0,0,0,40], 100, 0, "Select the one sharp note")
