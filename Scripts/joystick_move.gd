extends Area2D

var event_index:int = -1
var joystick_press:bool = false
var direccion:Vector2

func _input(event: InputEvent) -> void:
	if event.is_class("InputEventScreenTouch"):
		if event.is_pressed() and event_index == -1:
			if global_position.distance_to(event.position) <= $CollisionShape2D.shape.radius:
				direccion = global_position.direction_to(event.position)
				joystick_press = true
				event_index = event.index
				$Palanca.global_position = event.position
		elif event.index == event_index:
			joystick_press = false
			event_index = -1
			$Palanca.position = Vector2.ZERO
			direccion = Vector2.ZERO
	if event.is_class("InputEventScreenDrag"):
		if event.index == event_index and joystick_press:
			direccion = global_position.direction_to(event.position)
			if global_position.distance_to(event.position) <= $CollisionShape2D.shape.radius:
					$Palanca.global_position = event.position
			else:
				$Palanca.position = (global_position.direction_to(event.position)) * $CollisionShape2D.shape.radius
