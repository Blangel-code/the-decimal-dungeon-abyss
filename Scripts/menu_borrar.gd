extends Panel

func _on_no_pressed() -> void:
	$"..".visible = false
	$"../../../Regresar".grab_focus(true)
	get_tree().paused = false

func _on_si_pressed() -> void:
	$"..".visible = false
	$"../../../Regresar".grab_focus(true)
	get_tree().paused = false
	var datos_nuevos:Dictionary = {
	"idioma" : TranslationServer.get_locale(),
	"cofres_descubiertos" : {"1" : false},
	"volumenes" : {"Music": global_data.datos_usuario["volumenes"]["Music"], "SFX" : global_data.datos_usuario["volumenes"]["SFX"]},
	"indice_opciones" : 0,
	"tiempo_transcurrido" : 0.0,
	"damage" : 0,
	"max_vida" : 5,
	"ruby" : 0,
	"player_name" : null,
	"color_crosshair" : Color("ffffffff"),
}
	global_data.datos_usuario = datos_nuevos
	global_data.GuardarArchivos()
