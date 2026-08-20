extends Control

func _on_submit_pressed() -> void:
	global_data.datos_usuario["player_name"] = $LineEdit.text
	if global_data.datos_usuario["player_name"]:
		SilentWolf.Scores.save_score(global_data.datos_usuario["player_name"], global_data.datos_usuario["tiempo_transcurrido"])
		$"../ColorRect/AnimationPlayer".play_backwards("place_name")
		await $"../ColorRect/AnimationPlayer".animation_finished
		visible = false
		$"../".mostrar_tiempo()
