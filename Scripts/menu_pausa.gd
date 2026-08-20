extends CanvasLayer

@onready var transicion:ColorRect = $"../Transicion"

func _on_jugar_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_tienda_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	global_data.GuardarArchivos()
	transicion.escena_a_cargar = "res://Escenas/tienda.tscn"

func _on_menu_principal_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/menu.tscn"
