extends HSlider

@export var nombre_bus:String
@onready var bus_idx:int = AudioServer.get_bus_index(nombre_bus)

func _ready() -> void:
	value = global_data.datos_usuario["volumenes"][nombre_bus]

func _on_value_changed(valor: float) -> void:
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(valor))
	global_data.datos_usuario["volumenes"][nombre_bus] = valor
