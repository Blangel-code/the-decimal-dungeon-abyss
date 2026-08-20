extends CharacterBody2D
class_name Enemy

@export var SPEED:float = 70.0
@export var vida:int
@export var damage:int
@export var arma_enemigo:AnimatedSprite2D

@onready var enemigo_ataca:AudioStreamPlayer2D = $enemigo_ataca
@onready var nav_agent:NavigationAgent2D = $NavigationAgent2D
@onready var hit_enemigo:AudioStreamPlayer2D = $sonido_recibe_golpe
@onready var sprite_enemy:AnimatedSprite2D = $AnimatedSprite2D
@onready var objetos:Node = get_node("/root/Node2D/Objetos")

var player:Jugador = global_data.personaje_seleccionado
var player_col:bool = false
var can_move:bool = true
var hit:bool = false
var can_attack:bool = true
var small_potion:ObjetoSuelo = preload("res://Escenas/pocion_pequena.tscn").instantiate()
var big_potion:ObjetoSuelo = preload("res://Escenas/big_potion.tscn").instantiate()
var flecha:ObjetoSuelo = preload("res://Escenas/arrow.tscn").instantiate()
var ruby:ObjetoSuelo
var muerto:bool = false

func _physics_process(_delta: float) -> void:
	if can_move and not hit:
		var direction:Vector2 = to_local(nav_agent.get_next_path_position()).normalized()
		if direction.x > 0:
			sprite_enemy.flip_h = false
		elif direction.x < 0:
			sprite_enemy.flip_h = true
		if arma_enemigo:
			$Area2D.look_at(player.global_position)
			arma_enemigo.flip_h = sprite_enemy.flip_h
		sprite_enemy.play("Walking")
		velocity = direction*SPEED
		move_and_slide()
	else:
		if not hit:
			sprite_enemy.play("Idle")
	Muerte()

func Attack(player_attack:Jugador, damage_attack:int) -> void:
	if can_attack:
		if arma_enemigo:
			arma_enemigo.play()
		player_attack.audio_hit.play()
		can_attack = false
		player_attack.vida -= damage_attack
		player_attack.sprite.play("Hit")
		player_attack.hit = true
		player_attack.animacion_espada.visible = false
		player_attack.animacion_espada.stop()
		enemigo_ataca.play()
		$Timer.start()
	
func Muerte():
	if vida <= 0 and not muerto:
		muerto = true
		$Timer.stop()
		can_attack = false
		$CollisionShape2D.disabled = true
		sprite_enemy.play("Dead")
		await sprite_enemy.animation_finished
		if scene_file_path.get_basename() == "res://Escenas/enemy_2" or scene_file_path.get_basename() == "res://Escenas/enemy_5":
			ruby = preload("res://Escenas/medium_ruby.tscn").instantiate()
			ruby.global_position = global_position
			objetos.add_child(ruby)
			dropear_item(1,10)
		elif scene_file_path.get_basename() == "res://Escenas/enemy_6":
			ruby = preload("res://Escenas/big_ruby.tscn").instantiate()
			ruby.global_position = global_position
			objetos.add_child(ruby)
			dropear_item(1,8)
		else:
			ruby = preload("res://Escenas/small_ruby.tscn").instantiate()
			ruby.global_position = global_position
			objetos.add_child(ruby)
			dropear_item(1,15)
		player.points -= 1
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugadores"):
		player_col = true
		can_move = false
		Attack(body, damage)

func _on_timer_timeout() -> void:
	can_attack = true
	if player_col and player:
		Attack(player, damage)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Jugadores"):
		can_move = true
		player_col = false

func _on_animated_sprite_2d_animation_finished() -> void:
	hit = false

func _on_timer_movimiento_timeout() -> void:
	nav_agent.target_position = player.global_position

func dropear_item(num:int, num_2:int) -> void:
	match randi_range(num,num_2):
		1:
			small_potion.global_position = global_position
			objetos.add_child(small_potion)
		2:
			small_potion.global_position = global_position
			objetos.add_child(small_potion)
		3:
			big_potion.global_position = global_position
			objetos.add_child(big_potion)
		4:
			flecha.global_position = global_position
			objetos.add_child(flecha)
		5:
			flecha.global_position = global_position
			objetos.add_child(flecha)
