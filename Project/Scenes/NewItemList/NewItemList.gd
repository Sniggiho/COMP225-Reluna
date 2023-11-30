@tool
extends Control

@export var backgroundMargin : int = 4

@export var sharpPressed : bool = true
@export var flatPressed : bool = true
var doubleSelect : bool = true

@export var neutralColor : Color = Color("b0b0b0")
@export var negativeColor : Color = Color(0.5, 0.5, 0.5)
@export var positiveColor : Color 

enum option {AccidentalChoice, DetuneDirection}
@export var type : option = option.AccidentalChoice

signal buttonsChanged

# Called when the node enters the scene tree for the first time.
func _ready():
	_updateButtonColor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	doubleSelect = type == option.DetuneDirection
	
	$Line2D.width = backgroundMargin
	$Line2D.points[0] = Vector2(self.size.x / 2.0, 0)
	$Line2D.points[1] = Vector2(self.size.x / 2.0, self.size.y)
	$ColorRect.size = self.size
	
	$Background.size = self.size + Vector2(2 * backgroundMargin, 2 * backgroundMargin)
	$Background.position = Vector2(-backgroundMargin, -backgroundMargin)
	
	$SharpButton.size = Vector2(self.size.x / 2.0 - backgroundMargin / 2.0, self.size.y)
	$SharpButton.position = Vector2(0, 0)
	
	$FlatButton.size = Vector2(self.size.x / 2.0 - backgroundMargin / 2.0, self.size.y)
	$FlatButton.position.x = self.size.x / 2.0 + backgroundMargin / 2.0
	
	
	
	$SharpButton/ColorRect.position = Vector2(backgroundMargin, backgroundMargin)
	$SharpButton/ColorRect.size = $SharpButton.size - 2 * Vector2(backgroundMargin, backgroundMargin)
	
	$FlatButton/ColorRect.position = Vector2(backgroundMargin, backgroundMargin)
	$FlatButton/ColorRect.size = $FlatButton.size - 2 * Vector2(backgroundMargin, backgroundMargin)
	
	if Engine.is_editor_hint():
		_updateButtonColor()
	


func _updateButtonColor() -> void:
	if sharpPressed:
		$SharpButton/ColorRect.color = positiveColor # Color(0.5, 0.5, 0.9)
	else:
		$SharpButton/ColorRect.color = negativeColor # Color(0.5, 0.5, 0.5)
		
	if flatPressed:
		$FlatButton/ColorRect.color = positiveColor # Color(0.5, 0.5, 0.9)
	else:
		$FlatButton/ColorRect.color = negativeColor # Color(0.5, 0.5, 0.5)


func _on_sharp_button_pressed():
	if doubleSelect:
		sharpPressed = !sharpPressed
		if not sharpPressed and not flatPressed:
			flatPressed = true
	else:
		sharpPressed = !sharpPressed
		flatPressed = true if not sharpPressed else false
	buttonsChanged.emit()


func _on_flat_button_pressed():
	if doubleSelect:
		flatPressed = !flatPressed
		if not sharpPressed and not flatPressed:
			sharpPressed = true
	else:
		flatPressed = !flatPressed
		sharpPressed = true if not flatPressed else false
	buttonsChanged.emit()


# Connected from self
# As designed, any time a button is clicked it will update itself and maybe the other one
func _on_buttons_changed():
	if type == option.AccidentalChoice:
		GLevelData.bySharps = sharpPressed
	else:
		# if both selected, it's 0. -1 if just flat, 1 if just sharp
		GLevelData.detuneDir = int(sharpPressed) - int(flatPressed)
	_updateButtonColor()
