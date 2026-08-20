extends CharacterBody2D

@export var vida:int
@export var damage:int
@export var arma_enemigo:AnimatedSprite2D

@onready var enemigo_ataca:AudioStreamPlayer2D = $enemigo_ataca
@onready var hit_enemigo:AudioStreamPlayer2D = $sonido_recibe_golpe
@onready var sprite_enemy:AnimatedSprite2D = $AnimatedSprite2D
@onready var objetos:Node = get_node("/root/Node2D/Objetos")
@onready var marcador:Marker2D = $marcador/Marker2D
@onready var hechizo_bola_fuego:PackedScene = preload("res://Escenas/bola_de_fuego.tscn") 

var player:Jugador = global_data.personaje_seleccionado
var hit:bool = false
var small_potion:ObjetoSuelo = preload("res://Escenas/pocion_pequena.tscn").instantiate()
var big_potion:ObjetoSuelo = preload("res://Escenas/big_potion.tscn").instantiate()
var flecha:ObjetoSuelo = preload("res://Escenas/arrow.tscn").instantiate()
var ruby:ObjetoSuelo
var muerto:bool = false

func _physics_process(_delta: float) -> void:
	var direction:Vector2 = global_position.direction_to(player.global_position)
	if not hit:
		if direction.x > 0:
			sprite_enemy.flip_h = false
		elif direction.x < 0:
			sprite_enemy.flip_h = true
		sprite_enemy.play("Walking")
	else:
		$Animacion_del_arma.stop()
	$marcador.look_at(player.global_position)
	Muerte()

func Muerte():
	if vida <= 0 and not muerto:
		muerto = true
		$Timer.stop()
		$CollisionShape2D.disabled = true
		sprite_enemy.play("Dead")
		await sprite_enemy.animation_finished
		ruby = preload("res://Escenas/medium_ruby.tscn").instantiate()
		ruby.global_position = global_position
		objetos.add_child(ruby)
		Dropear_item(1,10)
		player.points -= 1
		queue_free()

func Attack() -> void:
	var bola_de_fuegoI:BolaDeFuego = hechizo_bola_fuego.instantiate()
	bola_de_fuegoI.global_position = marcador.global_position
	bola_de_fuegoI.rotation = $marcador.rotation
	get_tree().get_root().get_node("Node2D/Jugador").add_child(bola_de_fuegoI)
	enemigo_ataca.play()
	$Timer.start()

func Dropear_item(num:int, num_2:int) -> void:
	match randi_range(num,num_2):
		1:
			small_potion.global_position = global_position
			objetos.add_child(small_potion)
		2:
			big_potion.global_position = global_position
			objetos.add_child(big_potion)
		3:
			small_potion.global_position = global_position
			objetos.add_child(small_potion)
		4:
			flecha.global_position = global_position
			objetos.add_child(flecha)
		5:
			flecha.global_position = global_position
			objetos.add_child(flecha)

func _on_timer_timeout() -> void:
	Attack()

func _on_animated_sprite_2d_animation_finished() -> void:
	$Animacion_del_arma.play()
	hit = false
