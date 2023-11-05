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
	10: tut10
}

func _ready():
	# set up each tutorial
	tut1.setup(true, ["c4","c4","c4","c4"], [0,0,-40,0], 100, 0, "Select the one flat note")
	tut2.setup(true, ["c4","c4","c4","c4"], [0,40,0,0], 100, 0, "Select the one sharp note")
	tut3.setup(true, ["c4","d4","e4","f4", "g4"], [0,0,0,-40,0], 100, 0, "Select the one flat note")
