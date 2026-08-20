extends Node2D
class_name Flecha

const DAMAGE:int = 1
const VELOCITY:int = 400

func _process(delta: float) -> void:
	position += transform.x * VELOCITY * delta

func Attack(enemy:CharacterBody2D) -> void:
	enemy.hit_enemigo.play()
	enemy.sprite_enemy.play("Hit")
	enemy.hit = true
	enemy.vida -= DAMAGE + global_data.datos_usuario["damage"]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Jugadores"):
		if body.is_in_group("enemys"):
			Attack(body)
		queue_free()
