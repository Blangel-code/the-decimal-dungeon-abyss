extends Area2D
class_name PuntoCarga

@export var nuevos_puntos:int
@export var pared:bool = true
@onready var paredes_nivel:TileMapLayer
signal nivel_cambiado()

func _ready() -> void:
	if pared:
		paredes_nivel = $"../Paredes_nivel"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugadores"):
		body.points = nuevos_puntos
		global_data.nivel_actual += 1
		emit_signal("nivel_cambiado")
		if not global_data.nivel_actual == 11:
			get_node("../../../../Enemys/Spawn_"+str(global_data.nivel_actual)+"/Timer").start()
			paredes_nivel.visible = true
			paredes_nivel.collision_enabled = true
		global_data.llave_mostrada = false
		queue_free()
