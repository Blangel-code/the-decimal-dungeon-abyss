extends Button

@onready var texto:String = text

func _on_pressed() -> void:
	text = ""
	$sonido_presionado.play()

func _on_button_up() -> void:
	text = texto

func _on_button_down() -> void:
	text = ""
