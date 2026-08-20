extends CanvasLayer

@onready var transicion:ColorRect = $Transicion
func _ready() -> void:
	$"Botones/Control del Volumen de la Musica".grab_focus()
	$"Botones/Color CrossHair".color = global_data.datos_usuario["color_crosshair"]

func _on_borrar_pressed() -> void:
	$"Botones/Borrar/Confirmar Borrar".visible = true
	$"Botones/Borrar/Confirmar Borrar/Confirmar Borrar/No".grab_focus()
	get_tree().paused = true

func _on_regresar_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/menu.tscn"

func _on_color_cross_hair_color_changed(color: Color) -> void:
	global_data.datos_usuario["color_crosshair"] = color
