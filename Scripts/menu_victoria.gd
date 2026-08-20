extends CanvasLayer

var velocidad:int = 60
@onready var label:RichTextLabel = $RichTextLabel
var llego_al_final:bool = true

func _ready() -> void:
	label.text = "\n\n\n\n\n\n\n[color=#b9901b][font=\"res://Fuentes de Texto/Jersey15-Regular.ttf\"]"+tr("label_victory")+"\n\n\n\n\n\n[font=\"res://Fuentes de Texto/DancingScript-VariableFont_wght.ttf\"]THE DECIMAL DUNGEON ABYSS\n\n[font=\"res://Fuentes de Texto/Jersey15-Regular.ttf\"][color=#ffffff][font_size=31]"+tr("label_creditos")+"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

func _process(delta):
	if not llego_al_final:
		label.get_v_scroll_bar().value += velocidad * delta
		if label.get_v_scroll_bar().value >= label.get_v_scroll_bar().max_value - label.get_v_scroll_bar().page:
			llego_al_final = true
			if global_data.internet_conectado:
				$menu_nombre.visible = true
				$menu_nombre/LineEdit.grab_focus()
				$ColorRect/AnimationPlayer.play("place_name")
			else:
				mostrar_tiempo()

func _on_regresar_menu_pressed() -> void:
	$"../Transicion/AnimationPlayer".play("Fade in")
	$"../Transicion".escena_a_cargar = "res://Escenas/menu.tscn"

func _on_cofre_cofre_abierto() -> void:
	$"../../Sonidos/Musica Dura".stop()
	$"../../Sonidos/Musica de Victoria".play()
	get_tree().paused = true
	visible = true
	$ColorRect/AnimationPlayer.play("Fade in")
	global_data.GuardarArchivos()

func mostrar_tiempo() -> void:
	var segundos:int = int(global_data.datos_usuario["tiempo_transcurrido"]) % 60
	var minutos:int = int(global_data.datos_usuario["tiempo_transcurrido"] / 60)
	$Control/Tiempo.text = "%02d:%02d" % [minutos, segundos]
	global_data.GuardarArchivos()
	$"ColorRect/AnimationPlayer".play("Win")
	$"Control/regresar_menu".grab_focus(true)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade in":
		llego_al_final = false
