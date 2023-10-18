extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_requested():
	visible = false
	pass # Replace with function body.


func _on_mouse_entered():
	print("Hello! Mouse entered the window :)") # Doesn't work how I thought it would
	pass # Replace with function body.


func _on_window_input(event):
#	Helpful for if we want to implement a keyboard input or app gesture to make the window close
#	print(event)
	pass # Replace with function body.
