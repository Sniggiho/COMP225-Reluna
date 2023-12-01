extends CanvasLayer
## Fade in and fade out scene transition effect
## can be used to go between any scenes

## Takes in the target scene you want to travel to 
## changes the scene with the effect
func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
