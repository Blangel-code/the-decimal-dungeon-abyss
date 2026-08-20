extends TouchScreenButton

func _on_pressed() -> void:
	modulate = modulate.darkened(0.5)

func _on_released() -> void:
	modulate = modulate.lightened(1)
