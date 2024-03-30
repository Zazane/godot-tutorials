extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("fade_to_black")
	
	# var inside_level_scene:  PackedScene = load("res://scenes/levels/inside.tscn")
	# get_tree().change_scene_to_packed.bind(inside_level_scene).call_deferred()
