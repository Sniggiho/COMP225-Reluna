@tool
#extends Resource
extends HSlider
class_name NewHSlider

@export_multiline var text : String

## Edit this value to be the minimum allowed value of the slider instead of min_value
@export var minActualValue : int = 4

## Margin number of pixels for a border
@export var margin : float = 20

## A given height
@export var height : float = 20

## Selects which side the "selected" bar starts from 
@export var flip : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_item_rect_changed_newhslider_base()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.custom_minimum_size.y = height
	$CenterContainer.custom_minimum_size = self.size
	$CenterContainer.size = self.size
	$Background.size = self.size
	$CenterContainer.size = self.size
	$CenterContainer/Text.text = self.text
	$CenterContainer/Text.add_theme_font_size_override("normal_font_size", self.size.y / 2.)
#
	$Selected.size.y = self.size.y
	
	$Border.size = self.size + Vector2(margin * 2, margin * 2)
	$Border.position = Vector2(-margin, -margin)
	
	_updateSelectedSize()
	pass


func _updateSelectedSize():
	if not flip:
		$Selected.size.x = value / max_value * self.size.x
	else:
		pass



func _on_value_changed_newhslider_base(passedValue):
	value = max(minActualValue, passedValue)
	_updateSelectedSize()
	pass # Replace with function body.


func _on_item_rect_changed_newhslider_base():
#	self.custom_minimum_size.y = height
#	$CenterContainer.custom_minimum_size = self.size
#	$CenterContainer.size = self.size
#	$Background.size = self.size
#	$CenterContainer.size = self.size
#	$CenterContainer/Text.text = self.text
#	$CenterContainer/Text.add_theme_font_size_override("normal_font_size", self.size.y / 2.)
##
#	$Selected.size.y = self.size.y
#
#	$Border.size = self.size + Vector2(margin * 2, margin * 2)
#	$Border.position = Vector2(-margin, -margin)
#
#	_updateSelectedSize()
	pass # Replace with function body.
