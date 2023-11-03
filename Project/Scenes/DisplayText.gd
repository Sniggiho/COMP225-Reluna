extends RichTextLabel


func _ready():
	self.refresh()
	
func refresh():
	self.clear()
	self.add_text(GLevelData.displayText)
