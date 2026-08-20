extends Node

func _ready() -> void:
	SilentWolf.configure({
	"api_key": "GQfgLQmFaMaMTziBPU8dM429CmLq9GgY5HFiPnYo",
	"game_id": "TheDecimalDungeonAbyss",
	"log_level": 1
	})
	SilentWolf.configure_scores({
	"open_scene_on_close": "res://Escenas/menu.tscn"
	})
var personaje_seleccionado:Jugador
var nivel_actual:int = 0
var llave_mostrada:bool = false
var juego_iniciado:bool = false
var internet_conectado:bool = false
var datos_usuario:Dictionary = {
	"idioma" : TranslationServer.get_locale(),
	"cofres_descubiertos" : {"1" : false},
	"volumenes" : {"Music": 1.0, "SFX" : 1.0},
	"indice_opciones" : 0,
	"tiempo_transcurrido" : 0.0,
	"damage" : 0,
	"max_vida" : 5,
	"ruby" : 0,
	"player_name" : null,
	"color_crosshair" : Color("ffffffff"),
}

var inventario:Dictionary = {
	"llave": false,
	"small_potion": 0,
	"big_potion": 0,
	"arrow": 5
}

func GuardarArchivos() -> void:
	var archivo_abierto:FileAccess = FileAccess.open("user://data_game.dat", FileAccess.WRITE)
	archivo_abierto.store_var(datos_usuario)
	archivo_abierto.close()
	archivo_abierto = null

func CargarArchivos() -> void:
	if FileAccess.file_exists("user://data_game.dat"):
		var archivo_abierto:FileAccess = FileAccess.open("user://data_game.dat", FileAccess.READ)
		datos_usuario = archivo_abierto.get_var()
		archivo_abierto.close()
		archivo_abierto = null
