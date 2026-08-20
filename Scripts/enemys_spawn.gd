extends Node

@onready var enemy_1:PackedScene = preload("res://Escenas/enemy_1.tscn")
@onready var enemy_2:PackedScene = preload("res://Escenas/enemy_2.tscn")
@onready var enemy_3:PackedScene = preload("res://Escenas/enemy_3.tscn")
@onready var enemy_4:PackedScene = preload("res://Escenas/enemy_4.tscn")
@onready var enemy_5:PackedScene = preload("res://Escenas/enemy_5.tscn")
@onready var enemy_6:PackedScene = preload("res://Escenas/enemy_6.tscn")

@onready var enemy_list:Dictionary = {
	"1" : [enemy_1, enemy_1, enemy_1, enemy_1, enemy_1, enemy_1, enemy_1, enemy_1, enemy_1, enemy_1],
	"2" : [enemy_2, enemy_2, enemy_2, enemy_2, enemy_2],
	"3" : [enemy_1, enemy_1, enemy_1, enemy_1, enemy_2, enemy_2, enemy_2],
	"4" : [enemy_3, enemy_3, enemy_3, enemy_1, enemy_1, enemy_1, enemy_1],
	"5" : [enemy_3, enemy_3, enemy_3, enemy_2, enemy_2, enemy_2, enemy_2],
	"6" : [enemy_4],
	"7" : [enemy_5, enemy_5, enemy_5, enemy_5, enemy_5, enemy_5, enemy_5, enemy_5, enemy_5, enemy_5],
	"8" : [enemy_6, enemy_6, enemy_6, enemy_6, enemy_6, enemy_6],
	"9" : [enemy_5, enemy_5, enemy_5, enemy_5, enemy_5, enemy_6, enemy_6, enemy_6, enemy_6, enemy_6],
	"10" : [enemy_4, enemy_4, enemy_3, enemy_3, enemy_3, enemy_6, enemy_6, enemy_6, enemy_6, enemy_6, enemy_5, enemy_5]
	}

@onready var spawn_enemigos:Node = $Enemigos
@onready var spawn1:Node2D
@onready var spawn2:Node2D
@onready var spawn3:Node2D

@onready var player:Jugador = get_node("/root/Node2D/Jugador/spawn_jugador").get_children()[0]
var enemy_colocar:PackedScene
var enemyI:CharacterBody2D
var enemigos_colocables:int
var pared_nivel_actual:Node
var pared_eliminada:bool = false

func _process(_delta: float) -> void:
	if player.points == 0 and not pared_eliminada:
		pared_eliminada = true
		get_node("Spawn_" + str(global_data.nivel_actual) +"/Timer").stop()
		pared_nivel_actual.queue_free()

func _on_timer_timeout() -> void:
	if enemigos_colocables != 0:
		enemy_colocar = enemy_list[str(global_data.nivel_actual)].pick_random()
		enemyI = enemy_colocar.instantiate()
		if spawn_enemigos.get_child_count() >= 3:
			return
		if global_data.nivel_actual == 10:
			if str(enemyI.name) == "Enemy_3":
				enemyI.global_position = spawn3.global_position
				spawn_enemigos.add_child(enemyI)
			else:
				match randi_range(1, 2):
					1:
						enemyI.global_position = spawn1.global_position
						spawn_enemigos.add_child(enemyI)
					2:
						enemyI.global_position = spawn2.global_position
						spawn_enemigos.add_child(enemyI)
		else:
			match randi_range(1, 3):
				1:
					enemyI.global_position = spawn1.global_position
					spawn_enemigos.add_child(enemyI)
				2:
					enemyI.global_position = spawn2.global_position
					spawn_enemigos.add_child(enemyI)
				3:
					enemyI.global_position = spawn3.global_position
					spawn_enemigos.add_child(enemyI)
		enemy_list[str(global_data.nivel_actual)].erase(enemy_colocar)
		enemigos_colocables -= 1
		
func _on_punto_carga_nivel_cambiado() -> void:
	pared_nivel_actual = get_node("../Mundo/Niveles/nivel_" + str(global_data.nivel_actual) + "/Paredes_nivel")
	enemigos_colocables = player.points
	spawn1 = get_node("Spawn_" + str(global_data.nivel_actual) +"/spawn1")
	spawn2 = get_node("Spawn_" + str(global_data.nivel_actual) +"/spawn2")
	spawn3 = get_node("Spawn_" + str(global_data.nivel_actual) +"/spawn3")
	pared_eliminada = false
