extends Node

@onready var spawn_jugador: Node2D = $"../Jugador/spawn_jugador"

func _process(_delta: float) -> void:
	var points:int = spawn_jugador.get_children()[0].points
	if not points and not global_data.llave_mostrada and not global_data.nivel_actual == 11:
		get_node("/root/Node2D/Llave/spawn_key_"+str(global_data.nivel_actual)).add_child(preload("res://Escenas/Llave.tscn").instantiate())
		global_data.llave_mostrada = true
