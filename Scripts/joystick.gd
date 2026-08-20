extends Area2D

var event_index:int = -1
var joystick_press:bool = false
var attack:InputEventAction = InputEventAction.new()
var shoot:InputEventAction = InputEventAction.new()
var arma_actual:InputEventAction = attack

func _ready() -> void:
	attack.set_action("Attack")
	shoot.set_action("Disparar_arco")
	attack.pressed = true
	shoot.pressed = true

func _input(event: InputEvent) -> void:
	if event.is_class("InputEventScreenTouch"):
		if event.is_pressed() and event_index == -1:
			if global_position.distance_to(event.position) <= $CollisionShape2D.shape.radius:
				joystick_press = true
				event_index = event.index
				$Palanca.global_position = event.position
		elif event.index == event_index:
			attack.pressed = joystick_press
			Input.parse_input_event(arma_actual)
			joystick_press = false
			event_index = -1
			$Palanca.position = Vector2.ZERO
	if event.is_class("InputEventScreenDrag"):
		if event.index == event_index and joystick_press:
			if global_position.distance_to(event.position) <= $CollisionShape2D.shape.radius:
					$Palanca.global_position = event.position	
			else:
				$Palanca.position = (global_position.direction_to(event.position)) * $CollisionShape2D.shape.radius

func _on_cambio_arma_pressed() -> void:
	if arma_actual == attack:
		arma_actual = shoot
		$"../cambio_arma/espada".visible = true
		$"../cambio_arma/arco".visible = false
		$Palanca/Espada.visible = false
		$Palanca/Arco.visible = true
	else:
		arma_actual = attack
		$"../cambio_arma/arco".visible = true
		$"../cambio_arma/espada".visible = false
		$Palanca/Arco.visible = false
		$Palanca/Espada.visible = true
