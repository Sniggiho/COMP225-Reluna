@tool
extends Control

@export var backgroundMargin : int = 4

@export var sharpPressed : bool = true
@export var flatPressed : bool = true
var doubleSelect : bool = true

@export var neutralColor : Color = Color("b0b0b0")
@export var negativeColor : Color = Color(0.5, 0.5, 0.5)
@export var positiveColor : Color 

@export var positiveFontColor : Color = Color(0.5, 0.5, 0.5)
@export var negativeFontColor : Color = Color(0.35, 0.35, 0.35)

@export var selectedColor : Color = Color(0.5, 0.5, 0.9)
var mouseIn1 : bool = false
var focusIn1 : bool = false
var mouseIn2 : bool = false
var focusIn2 : bool = false

enum option {AccidentalChoice, DetuneDirection}
@export var type : option = option.AccidentalChoice

@export var topFocus : Control

signal buttonsChanged

# Called when the node enters the scene tree for the first time.
func _ready():
	if type == option.AccidentalChoice:
		$SharpButton.grab_focus()
		
	if topFocus:
		$SharpButton.focus_neighbor_top = $SharpButton.get_path_to(topFocus)
		$FlatButton.focus_neighbor_top = $FlatButton.get_path_to(topFocus)
	
	_updateButtonColor()
	
	if GLevelData.valid:
		if type == option.DetuneDirection:
			var dir = GLevelData.detuneDir
			sharpPressed = true if dir == 0 or dir == 1 else false
			flatPressed = true if dir == -1 or dir == 0 else false
		else: # Accidental Choice, bySharp
			sharpPressed = GLevelData.bySharps
			flatPressed = !GLevelData.bySharps
		_updateButtonColor()
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	doubleSelect = type == option.DetuneDirection
	
	$Line2D.width = backgroundMargin
	$Line2D.points[0] = Vector2(self.size.x / 2.0, 0)
	$Line2D.points[1] = Vector2(self.size.x / 2.0, self.size.y)
	
#	$ColorRect.size = self.size
	$Foreground1.size = Vector2(self.size.x / 2.0, self.size.y)
	$Foreground2.size = Vector2(self.size.x / 2.0, self.size.y)
	$Foreground2.position.x = self.size.x / 2.0
	
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
	
	$SharpButton/CenterContainer.size = $SharpButton.size
	$FlatButton/CenterContainer.size = $FlatButton.size
	
	$SharpButton/CenterContainer/RichTextLabel.add_theme_font_size_override("normal_font_size", self.size.y / 2.5)
	$FlatButton/CenterContainer/RichTextLabel.add_theme_font_size_override("normal_font_size", self.size.y / 2.5)
	
	_updateFocusColoring()
	
	if Engine.is_editor_hint():
		_updateButtonColor()
	


func _updateButtonColor() -> void:
	if sharpPressed:
		$SharpButton/ColorRect.color = positiveColor # Color(0.5, 0.5, 0.9)
		$SharpButton/CenterContainer/RichTextLabel.add_theme_color_override("default_color", positiveFontColor)
	else:
		$SharpButton/ColorRect.color = negativeColor # Color(0.5, 0.5, 0.5)
		$SharpButton/CenterContainer/RichTextLabel.add_theme_color_override("default_color", negativeFontColor)
		
	if flatPressed:
		$FlatButton/ColorRect.color = positiveColor # Color(0.5, 0.5, 0.9)
		$FlatButton/CenterContainer/RichTextLabel.add_theme_color_override("default_color", positiveFontColor)
	else:
		$FlatButton/ColorRect.color = negativeColor # Color(0.5, 0.5, 0.5)
		$FlatButton/CenterContainer/RichTextLabel.add_theme_color_override("default_color", negativeFontColor)


# Update with respect to focus and mouse in for each foreground
func _updateFocusColoring() -> void:
	if mouseIn1 or focusIn1:
		$Foreground1.color = selectedColor
	else:
		$Foreground1.color = neutralColor
		
	if mouseIn2 or focusIn2:
		$Foreground2.color = selectedColor
	else:
		$Foreground2.color = neutralColor


## Expose button child so focus neighbors can be set
func getSharpButton() -> Button:
	return $SharpButton
	

## Expose button child so focus neighbors can be set
func getFlatButton() -> Button:
	return $FlatButton


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




func _on_sharp_button_focus_entered():
	focusIn1 = true


func _on_sharp_button_focus_exited():
	focusIn1 = false


func _on_sharp_button_mouse_entered():
	mouseIn1 = true


func _on_sharp_button_mouse_exited():
	mouseIn1 = false


func _on_flat_button_focus_entered():
	focusIn2 = true


func _on_flat_button_focus_exited():
	focusIn2 = false


func _on_flat_button_mouse_entered():
	mouseIn2 = true


func _on_flat_button_mouse_exited():
	mouseIn2 = false
