@tool
extends HSlider
class_name NewHSlider

@export_multiline var text : String

## Edit this value to be the minimum allowed value of the slider instead of min_value
@export var minActualValue : int = 4

## Currently unused, margin number of pixels for a border
@export var margin : float = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CenterContainer.custom_minimum_size = self.size
	$Background.updateBounds(self)
	$CenterContainer.updateBounds(self)
	$CenterContainer/Text.text = self.text
	$CenterContainer/Text.add_theme_font_size_override("normal_font_size", self.size.y / 2.)
#
	$Selected.size.y = self.size.y
	$Selected.maxWidth = self.size.x
	
	_updateSelectedSize()
	pass


func _updateSelectedSize():
	$Selected.size.x = value / max_value * self.size.x


## CONNECTED FROM SELF
func _on_value_changed(passedValue):
	value = max(minActualValue, passedValue)
	_updateSelectedSize()
	pass # Replace with function body.
