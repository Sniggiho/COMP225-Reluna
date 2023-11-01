extends Node2D

var tutorial : bool # true for tutorials, false for freeplay

# shared settings
var bySharps : bool
var bpm : int

# free play settings
var numAccidentals : int
var lowestNote : String
var highestNote : String
var detunedList : Array
var detuneDir : int # -1 for flat only, 0 for both, 1 for sharp only
var maxDetuneCents : int
var minDetuneCents : int

# tutorial settings
var notes : Array
var detunedAmountsList : Array
