extends Control

var personajes_disponibles:Array = ["knight", "knight_2", "elf", "elf_2"]
var nombres_personajes:Array = ["NOEL", "PAUL", "LIFA", "RUDEUS"]

@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	$Derecha.grab_focus(true)
	seleccionar_personaje()

func seleccionar_personaje():
	var frame_anterior:int = sprite.frame
	$Label.text = nombres_personajes[global_data.datos_usuario["indice_opciones"]]
	sprite.play(personajes_disponibles[global_data.datos_usuario["indice_opciones"]])
	sprite.frame = frame_anterior
	
func _on_derecha_pressed() -> void:
	if global_data.datos_usuario["indice_opciones"] < 3:
		global_data.datos_usuario["indice_opciones"] += 1
	else:
		global_data.datos_usuario["indice_opciones"] = 0
	seleccionar_personaje()

func _on_izquierda_pressed() -> void:
	if global_data.datos_usuario["indice_opciones"] > 0:
		global_data.datos_usuario["indice_opciones"] -= 1
	else:
		global_data.datos_usuario["indice_opciones"] = personajes_disponibles.size()-1
	seleccionar_personaje()

func _on_atras_pressed() -> void:
	$Transicion/AnimationPlayer.play("Fade in")
	$Transicion.escena_a_cargar = "res://Escenas/menu.tscn"
