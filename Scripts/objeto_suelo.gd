extends Area2D
class_name ObjetoSuelo

@export var nombre_objeto:String = ""
@onready var inventario:Dictionary = global_data.inventario

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugadores"):
		if nombre_objeto == "llave":
			inventario[nombre_objeto] = true
		elif nombre_objeto == "arrow":
			inventario[nombre_objeto] += 3
		elif nombre_objeto.contains("ruby"):
			if nombre_objeto == "small_ruby":
				global_data.datos_usuario["ruby"] += 1
			elif nombre_objeto == "medium_ruby":
				global_data.datos_usuario["ruby"] += 3
			elif nombre_objeto == "big_ruby":
				global_data.datos_usuario["ruby"] += 10
		else:
			inventario[nombre_objeto] += 1
		queue_free()
