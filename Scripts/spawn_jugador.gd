extends Node

@onready var spawn = $spawn_jugador
@onready var nuevo_personaje:Jugador = load("res://Escenas/Player.tscn").instantiate()

@export var caballero:SpriteFrames
@export var caballero_2:SpriteFrames
@export var elfo:SpriteFrames
@export var elfo_2:SpriteFrames
@onready var skins:Array = [caballero, caballero_2, elfo, elfo_2]

func _process(delta: float) -> void:
	global_data.datos_usuario["tiempo_transcurrido"] += delta

func _ready() -> void:
	global_data.nivel_actual = 0
	nuevo_personaje.skin = skins[global_data.datos_usuario["indice_opciones"]]
	global_data.personaje_seleccionado = nuevo_personaje
	spawn.add_child(global_data.personaje_seleccionado)
	await $"../Menu/Transicion/AnimationPlayer".animation_finished
	nuevo_personaje.ui_usuario.visible = true

func _on_punto_carga_nivel_cambiado() -> void:
	if not global_data.datos_usuario["cofres_descubiertos"]["1"] and global_data.nivel_actual == 1:
		$"../Objetos/Cofre".process_mode = Node.PROCESS_MODE_INHERIT
		$"../Objetos/Cofre".visible = true
	if global_data.nivel_actual == 6 or global_data.nivel_actual == 10:
		$"../Sonidos/Musica de fondo".stop()
		$"../Sonidos/Musica Dura".play()
	elif not $"../Sonidos/Musica de fondo".playing:
		$"../Sonidos/Musica Dura".stop()
		$"../Sonidos/Musica de fondo".play()
	$spawn_jugador/Player/ui_usuario/Nivel.text = tr("label_level")+" "+str(global_data.nivel_actual)
	$spawn_jugador/Player/ui_usuario/Nivel/AnimationPlayer.play("Nivel Pasado")
	nuevo_personaje.barra_de_enemigos.max_value = nuevo_personaje.points
