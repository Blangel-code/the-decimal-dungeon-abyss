extends Node2D
class_name BolaDeFuego

const DAMAGE:int = 4
const VELOCITY:int = 400

func _process(delta: float) -> void:
	position += transform.x * VELOCITY * delta

func Attack(player_attack:Jugador) -> void:
	player_attack.audio_hit.play()
	player_attack.vida -= DAMAGE
	player_attack.sprite.play("Hit")
	player_attack.hit = true
	player_attack.animacion_espada.visible = false
	player_attack.animacion_espada.stop()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("enemys"):
		if body.is_in_group("Jugadores"):
			Attack(body)
		queue_free()
