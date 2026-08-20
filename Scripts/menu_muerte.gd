extends CanvasLayer

@onready var transicion:ColorRect = $"../Transicion"

func _on_volver_jugar_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/mundo.tscn"

func _on_tienda_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/tienda.tscn"

func _on_regresar_menu_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/menu.tscn"

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	$Control/volver_jugar.grab_focus(true)
	$Control.visible = true
