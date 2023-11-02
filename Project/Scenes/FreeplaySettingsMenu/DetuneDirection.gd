extends ItemList

## Sets Detune direction based on clicking on the item list
##
## 1 is sharp, 0 is both, -1 is flat.
##
## The item list order is sharp (index 0), both (index 1), and flat (index 2).
## Map those together. 

var map : Array = [1, 0, -1]


# Select both by default
func _ready() -> void:
	self.select(1)
	GLevelData.detuneDir = 0


# Given the index of the list accessed, reference the map and set GLevelData
func _on_item_selected(index) -> void:
	GLevelData.detuneDir = map[index]
	

