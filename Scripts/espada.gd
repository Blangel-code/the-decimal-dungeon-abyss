extends Node2D

@onready var animacion:AnimatedSprite2D = $animacion_espada
@onready var jugador:Jugador = global_data.personaje_seleccionado

const DAMAGE:int = 1
var enemy_list_entered_sword:Array = []

func _on_animacion_espada_animation_finished() -> void:
	jugador.can_attack = true
	animacion.visible = false

func Attack(damage_global:int) -> void:
	animacion.visible = true
	if $"../CrossHair".global_position.x > $"../Area2D".global_position.x:
		jugador.sprite.flip_h = false
		animacion.flip_h = false
	else:
		jugador.sprite.flip_h = true
		animacion.flip_h = true
	animacion.play("Attack")
	$sonido_espada.play()
	if enemy_list_entered_sword:
		for enemy in enemy_list_entered_sword:
			enemy.hit_enemigo.play()
			enemy.sprite_enemy.play("Hit")
			enemy.hit = true
			enemy.vida -= DAMAGE + damage_global
	jugador.can_attack = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemys"):
		enemy_list_entered_sword.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemys"):
		enemy_list_entered_sword.erase(body)
