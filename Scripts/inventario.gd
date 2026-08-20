extends Node

var corazones_5:Dictionary = {
	"lleno" = preload("res://Sprites/Menus/Barras de progresos/Lleno_5_corazones1.png"),
	"marco" = preload("res://Sprites/Menus/Barras de progresos/Marco_5_corazones1.png"),
	"vacio" = preload("res://Sprites/Menus/Barras de progresos/Vacios_5_corazones1.png"),
}
var corazones_4:Dictionary = {
	"lleno" = preload("res://Sprites/Menus/Barras de progresos/Lleno_4_corazones1.png"),
	"marco" = preload("res://Sprites/Menus/Barras de progresos/Marco_4_corazones1.png"),
	"vacio" = preload("res://Sprites/Menus/Barras de progresos/Vacios_4_corazones1.png"),
}
var corazones_3:Dictionary = {
	"lleno" = preload("res://Sprites/Menus/Barras de progresos/Lleno_corazones1.png"),
	"marco" = preload("res://Sprites/Menus/Barras de progresos/Marco_corazones1.png"),
	"vacio" = preload("res://Sprites/Menus/Barras de progresos/Vacios_corazones1.png"),
}
var corazones_2:Dictionary = {
	"lleno" = preload("res://Sprites/Menus/Barras de progresos/Lleno_2_corazones1.png"),
	"marco" = preload("res://Sprites/Menus/Barras de progresos/Marco_2_corazones1.png"),
	"vacio" = preload("res://Sprites/Menus/Barras de progresos/Vacios_2_corazones1.png"),
}
var corazones_1:Dictionary = {
	"lleno" = preload("res://Sprites/Menus/Barras de progresos/Lleno_1_corazon1.png"),
	"marco" = preload("res://Sprites/Menus/Barras de progresos/Marco_1_corazon1.png"),
	"vacio" = preload("res://Sprites/Menus/Barras de progresos/Vacios_1_corazon1.png"),
}

var lista_de_barra_de_vida:Array = [corazones_1,corazones_2,corazones_3,corazones_4,corazones_5]

func _ready() -> void:
	var vida:TextureProgressBar = $"vida"
	global_data.inventario = {
	"llave": false,
	"small_potion": 0,
	"big_potion": 0,
	"arrow": 5
	}
	var barra_de_vida:Dictionary = lista_de_barra_de_vida[(global_data.datos_usuario["max_vida"]/5.0) -1]
	vida.max_value = global_data.datos_usuario["max_vida"]
	vida.texture_progress = barra_de_vida["lleno"]
	vida.texture_over = barra_de_vida["marco"]
	vida.texture_under = barra_de_vida["vacio"]

func _process(_delta: float) -> void:
	if global_data.inventario["llave"]:
		$GridContainer/animacion_llave.visible = true
	else:
		$GridContainer/animacion_llave.visible = false
	
	$ruby/Label.text = str(global_data.datos_usuario["ruby"])
	$GridContainer/flechas/Label.text = str(global_data.inventario["arrow"])
	$GridContainer/small_potion/Label.text = str(global_data.inventario["small_potion"])
	$GridContainer/big_potion/Label.text = str(global_data.inventario["big_potion"])
