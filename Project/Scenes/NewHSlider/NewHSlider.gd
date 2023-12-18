@tool
extends HSlider
class_name NewHSlider

@export_multiline var text : String
#var hasLabel : bool = false

## Edit this value to be the minimum allowed value of the slider instead of min_value
@export var minActualValue : int = 0

## The max value may be some value you want the slider to reflect but not actually reach
@export var maxActualValue : int = 30

## Margin number of pixels for a border
@export var margin : float = 20

## Inner margin width around the selected bar
@export var innerMargin : float = 10

## A given height
@export var height : float = 20


@export_color_no_alpha var backgroundColor : Color = Color("afafaf")
@export_color_no_alpha var backgroundSelectedColor : Color = Color("98d3e6")
var mouseIn : bool = false
var focusIn : bool = false

signal selectedChanged

@export_color_no_alpha var positiveTextColor : Color
@export_color_no_alpha var negativeTextColor : Color

# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	


func _ready2():
	$CenterContainer/Text.defaultText = text
	$CenterContainer/Text.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not (min_value < max_value):
		max_value = min_value + 1
	if Engine.is_editor_hint():
		$CenterContainer/Text.text = text
	self.custom_minimum_size.y = height
	$CenterContainer.custom_minimum_size = self.size
	$CenterContainer.size = self.size
	$Background.size = self.size
	$CenterContainer.size = self.size
#	$CenterContainer/Text.text = self.text
	$CenterContainer/Text.add_theme_font_size_override("normal_font_size", self.size.y / 2.5)
#
	$Selected.size.y = self.size.y
	
	$Border.size = self.size + Vector2(margin * 2, margin * 2)
	$Border.position = Vector2(-margin, -margin)
	
	_updateSelectedSize()
	_updateBackgroundColor()
	_updateShader()
	pass


func _updateSelectedSize() -> void:
	# Improved so while (min_value < max_value), min_value can be anything and the bar still works
	$Selected.position = Vector2(innerMargin, innerMargin)
	$Selected.size.x = (value - min_value) / (max_value - min_value) * self.size.x - 2 * innerMargin
	$Selected.size.y = self.size.y - 2 * innerMargin
	
	if $Selected.size.x < 5:
		$Selected.size.x = 5
		
	selectedChanged.emit()


func _updateShader() -> void:
	# Transforms to UV coords, essentially, for the right edge of Selected
	var screen = get_viewport_rect().size
	var right = ($Selected.global_position.x + $Selected.size.x) / screen.x
	$CenterContainer/Text.get_material().set_shader_parameter("rightEdge", right)
	$CenterContainer/Text.get_material().set_shader_parameter("positiveTextColor", positiveTextColor)
	$CenterContainer/Text.get_material().set_shader_parameter("negativeTextColor", negativeTextColor)


# This should be the only point where you directly change value
# If a derived class changes value in this way, it will lead to circular references
func _on_value_changed_newhslider_base(passedValue) -> void:
	value = max(minActualValue, min(maxActualValue, passedValue))
	_updateSelectedSize()

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

