@tool
extends RichTextLabel

var defaultText : String

func updateLabel(label : String) -> void:
	text = defaultText + ": " + label
