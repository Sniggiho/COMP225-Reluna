extends OptionButton


var map : Array = [false, true]

func _updateSetting():
	GLevelData.bySharps = map[selected]
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	if GLevelData.valid:
		selected = map.find(GLevelData.bySharps)
	
	_updateSetting()


## CONNECTED FROM SELF
func _on_item_selected(_index):
	_updateSetting()
