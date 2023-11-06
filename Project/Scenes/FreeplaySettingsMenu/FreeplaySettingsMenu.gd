extends Node2D
class_name FreeplaySettingsMenu

func generatePossibleNotes() -> Array:
	var noteOrder = ["c","c-","d","d-","e","f","f-","g","g-","a","a-","b"]
	var possibleNotes = []
	for i in range(3,6):
		for n in noteOrder:
			var noteName = n + str(i)
			possibleNotes.append(noteName)
	
	possibleNotes.append("c6")
	return possibleNotes
