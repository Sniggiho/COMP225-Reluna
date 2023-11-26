@tool
extends HSlider
class_name NewHSlider

@export_multiline var text : String
#var hasLabel : bool = false

## Edit this value to be the minimum allowed value of the slider instead of min_value
@export var minActualValue : int = 4

## Margin number of pixels for a border
@export var margin : float = 20

## A given height
@export var height : float = 20

## Selects which side the "selected" bar starts from 
@export var flip : bool = false


@export_color_no_alpha var backgroundColor : Color = Color("afafaf")
@export_color_no_alpha var backgroundSelectedColor : Color = Color("98d3e6")
var mouseIn : bool = false
var focusIn : bool = false



# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()


func _ready2():
	$CenterContainer/Text.defaultText = text
	$CenterContainer/Text.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		$CenterContainer/Text.text = text
	self.custom_minimum_size.y = height
	$CenterContainer.custom_minimum_size = self.size
	$CenterContainer.size = self.size
	$Background.size = self.size
	$CenterContainer.size = self.size
#	$CenterContainer/Text.text = self.text
	$CenterContainer/Text.add_theme_font_size_override("normal_font_size", self.size.y / 2.)
#
	$Selected.size.y = self.size.y
	
	$Border.size = self.size + Vector2(margin * 2, margin * 2)
	$Border.position = Vector2(-margin, -margin)
	
	_updateSelectedSize()
	_updateBackgroundColor()
	pass


func _updateSelectedSize() -> void:
	if not flip:
		$Selected.size.x = value / max_value * self.size.x
	else:
		pass


func _on_value_changed_newhslider_base(passedValue) -> void:
	value = max(minActualValue, passedValue)
	_updateSelectedSize()
	pass # Replace with function body.


func updateLabel(label : String) -> void:
	$CenterContainer/Text.updateLabel(label)


func _updateBackgroundColor() -> void:
	if mouseIn or focusIn:
		$Background.color = backgroundSelectedColor
	if (not mouseIn) and (not focusIn):
		$Background.color = backgroundColor


func _on_mouse_entered() -> void:
	mouseIn = true


func _on_mouse_exited() -> void:
	mouseIn = false


func _on_focus_entered() -> void:
	focusIn = true


func _on_focus_exited() -> void:
	focusIn = false

