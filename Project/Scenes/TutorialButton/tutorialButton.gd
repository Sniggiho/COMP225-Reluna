extends Button

@export var tutorialFilePath : String

func _on_pressed():
	SceneTransition.change_scene("res://Scenes/firstScene.tscn")
