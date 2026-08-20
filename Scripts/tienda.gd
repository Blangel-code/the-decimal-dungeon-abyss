extends Control

var imagen:Texture2D = preload("res://Sprites/Objetos/ruby.png")


func _ready() -> void:
	$Damage/comprar_damage.grab_focus(true)
	if global_data.datos_usuario["damage"] < 8:
		$Damage/RichTextLabel.text = str(int($Damage/RichTextLabel.text) *2**global_data.datos_usuario["damage"])
		$Damage/RichTextLabel.add_image(imagen, 70, 70)
	else:
		$Damage/RichTextLabel.text = "1000"
		$Damage/RichTextLabel.add_image(imagen, 70, 70)
	if global_data.datos_usuario["max_vida"] == 25:
		$Life/RichTextLabel.text = "[color=red]MAX"
		$Life/comprar_life.disabled = true
	else:
		$Life/RichTextLabel.text = str(int($Life/RichTextLabel.text) *3**int(global_data.datos_usuario["max_vida"]/5.0))
		$Life/RichTextLabel.add_image(imagen, 70, 70)
	comprar()

func comprar() -> void:
	$Damage/stats_damage.text = " [color=red]"+str(global_data.datos_usuario["damage"])+" [color=green]-> "+str(global_data.datos_usuario["damage"]+1)
	$Life/stats_life.text = " [color=red]"+str(global_data.datos_usuario["max_vida"])+" [color=green]-> "+str(global_data.datos_usuario["max_vida"]+5)
	$ruby/cantidad_ruby.text = str(global_data.datos_usuario["ruby"])

func _on_comprar_damage_pressed() -> void:
	if global_data.datos_usuario["ruby"] < int($Damage/RichTextLabel.text):
		return
	global_data.datos_usuario["ruby"] -= int($Damage/RichTextLabel.text)
	global_data.datos_usuario["damage"] += 1
	if global_data.datos_usuario["damage"] >= 8:
		$Damage/RichTextLabel.text = str(1000)	
		if global_data.datos_usuario["damage"] == 8:
			$Damage/RichTextLabel.add_image(imagen, 70, 70)
	else:
		$Damage/RichTextLabel.text = str(int($Damage/RichTextLabel.text) *2)
		$Damage/RichTextLabel.add_image(imagen, 70, 70)
	comprar()

func _on_comprar_life_pressed() -> void:
	if global_data.datos_usuario["ruby"] < int($Life/RichTextLabel.text):
		return
	global_data.datos_usuario["max_vida"] += 5
	global_data.datos_usuario["ruby"] -= int($Life/RichTextLabel.text)
	comprar()
	if global_data.datos_usuario["max_vida"] == 25:
		$Life/RichTextLabel.text = "[color=red]MAX"
		$Life/comprar_life.disabled = true
		return
	$Life/RichTextLabel.text = str(int($Life/RichTextLabel.text) *3)
	$Life/RichTextLabel.add_image(imagen, 70, 70)

func _on_salir_pressed() -> void:
	$Transicion/AnimationPlayer.play("Fade in")
	$Transicion.escena_a_cargar = "res://Escenas/menu.tscn"
