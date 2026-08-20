extends StaticBody2D
signal cofre_abierto

var abierto:bool = false
@export var ruby:int
@export var numero_de_cofre:String

func _on_timer_timeout() -> void:
	global_data.datos_usuario["ruby"] += ruby
	emit_signal("cofre_abierto")

func _on_cofre_body_entered(body: Node2D) -> void:
	if int(numero_de_cofre) > 0:
		global_data.datos_usuario["cofres_descubiertos"][numero_de_cofre] = true
	if body.is_in_group("Jugadores") and not abierto:
		abierto = true
		$Cofre/Timer.start()
		$Cofre/AnimatedSprite2D.play()
