extends Node2D
class_name Arco

@onready var jugador:Jugador = global_data.personaje_seleccionado
@onready var animacion:AnimatedSprite2D = $animacion_arco
@onready var marcador:Marker2D = $marcador/Marker2D
var flecha_cargada:PackedScene = preload("res://Escenas/flecha.tscn")

func _physics_process(_delta: float) -> void:
	if $"../CrossHair".global_position.x > $marcador.global_position.x:
		animacion.flip_h = false
		jugador.sprite.flip_h = false
	else:
		jugador.sprite.flip_h = true
		animacion.flip_h = true
	$marcador.look_at($"../CrossHair".global_position)

func disparar() -> void:
	jugador.can_attack = false
	animacion.play()
	visible = true

func disparar_flecha() -> void:
	var flecha:Flecha = flecha_cargada.instantiate()
	flecha.global_position = marcador.global_position
	flecha.rotation = $marcador.rotation
	get_tree().get_root().get_node("Node2D/Jugador").add_child(flecha)
	global_data.inventario["arrow"] -= 1
	visible = false

func _on_animacion_arco_animation_finished() -> void:
	jugador.can_attack = true
	disparar_flecha()
