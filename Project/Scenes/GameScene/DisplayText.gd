extends RichTextLabel
## Displays what the user needs to do in this level

func _ready():
	self.refresh()
	
func refresh():
	self.clear()
	self.add_text(GLevelData.displayText)
