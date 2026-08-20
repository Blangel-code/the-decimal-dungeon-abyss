extends StaticBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugadores"):
		if global_data.inventario["llave"]:
			$puerta_abriendose.play()
			global_data.inventario["llave"] = false
			queue_free()
