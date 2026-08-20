extends ColorRect

var escena_a_cargar:String

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade in":
		get_tree().paused = false
		get_tree().change_scene_to_file(escena_a_cargar)
