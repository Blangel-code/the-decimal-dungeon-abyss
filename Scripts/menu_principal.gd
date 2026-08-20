extends Control

@onready var transicion:ColorRect = $Transicion

var segundos:int
var minutos:int

func _ready() -> void:
	if not global_data.juego_iniciado:
		global_data.juego_iniciado = true
		if FileAccess.file_exists("user://data_game.dat"):
			global_data.CargarArchivos()
			TranslationServer.set_locale(global_data.datos_usuario["idioma"])
		AudioServer.set_bus_volume_db(1, linear_to_db(global_data.datos_usuario["volumenes"]["Music"]))
		AudioServer.set_bus_volume_db(2, linear_to_db(global_data.datos_usuario["volumenes"]["SFX"]))
	else:
		global_data.GuardarArchivos()
	global_data.internet_conectado = false
	$"Musica de Fondo".play()
	$Botones/Play.grab_focus(true)
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	sw_result.scores.reverse()
	var position_leaderboard:int = 1
	for score in sw_result.scores:
		segundos = int(score.score) % 60
		minutos = int(score.score / 60)
		var label_position:Label = Label.new()
		var label_nombre:Label = Label.new()
		var label_tiempo:Label = Label.new()
		label_position.label_settings = preload("res://new_label_settings.tres")
		label_nombre.label_settings = preload("res://new_label_settings.tres")
		label_tiempo.label_settings = preload("res://new_label_settings.tres")
		label_position.text = str(position_leaderboard)
		label_nombre.text = score.player_name
		label_tiempo.text = "%02d:%02d" % [minutos, segundos]
		position_leaderboard += 1
		$Leaderboard/GridContainer/Position.add_child(label_position)
		$Leaderboard/GridContainer/Name.add_child(label_nombre)
		$Leaderboard/GridContainer/Tiempo.add_child(label_tiempo)
		if position_leaderboard == 7:
			break
	$Leaderboard/leaderboard_anim.play("leaderboard_visible")
	global_data.internet_conectado = true

func _on_play_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/pantalla_de_carga.tscn"

func _on_personajes_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/menu_personajes.tscn"

func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_shop_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/tienda.tscn"

func _on_opciones_pressed() -> void:
	transicion.get_node("AnimationPlayer").play("Fade in")
	transicion.escena_a_cargar = "res://Escenas/menu_opciones.tscn"

func _on_idioma_pressed() -> void:
	var idioma_a_cambiar:String
	if TranslationServer.get_locale().begins_with("es"):
		idioma_a_cambiar = "en"
	elif TranslationServer.get_locale() == "en":
		idioma_a_cambiar = "es"
	TranslationServer.set_locale(idioma_a_cambiar)
	global_data.datos_usuario["idioma"] = idioma_a_cambiar
	global_data.GuardarArchivos()
