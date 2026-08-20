extends CharacterBody2D
class_name Jugador

#si coloco ../ significa que acceda a un nodo padre

const SPEED:int = 120

@onready var ui_usuario:CanvasLayer = $ui_usuario
@onready var barra_de_vida:TextureProgressBar = $ui_usuario/vida
@onready var barra_de_enemigos:TextureProgressBar = $ui_usuario/enemigos
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_hit:AudioStreamPlayer2D = $sonido_hit
@onready var animacion_espada:AnimatedSprite2D = $Espada/animacion_espada
@onready var joystick:Area2D = $ui_usuario/botones_telefono/Joystick

var muerto:bool = false
var vida:int = 0
var can_attack:bool = true
var enemy_col:bool = false
var points:int = 1
var hit:bool = false
var skin:SpriteFrames
var input_vector:float
var has_control:bool
var has_mouse:bool = true
var direction:Vector2
var mobile_device:bool

func _ready() -> void:
	sprite.sprite_frames = skin
	vida = global_data.datos_usuario["max_vida"]
	$CrossHair.modulate = global_data.datos_usuario["color_crosshair"]
	mobile_device = DisplayServer.is_touchscreen_available()
	 
func get_input_direction(angle:Vector2=Vector2.ZERO) -> float:
	if has_control:
		angle.x = Input.get_axis("mirar_izquierda(mando)", "mirar_derecha(mando)")
		angle.y = Input.get_axis("mirar_arriba(mando)", "mirar_abajo(mando)")
		$ui_usuario/botones_pc.visible = false
		$ui_usuario/botones_mando.visible = true
		$ui_usuario/botones_telefono.visible = false
	elif has_mouse and not mobile_device:
		angle = (get_global_mouse_position() - global_position).normalized()
		$ui_usuario/botones_pc.visible = true
		$ui_usuario/botones_mando.visible = false
		$ui_usuario/botones_telefono.visible = false
	else:
		$ui_usuario/botones_telefono.visible = true
		$ui_usuario/botones_pc.visible = false
		$ui_usuario/botones_mando.visible = false
	if angle.length() > 0.2:
		return angle.angle() 
	return input_vector

func _physics_process(_delta: float) -> void:
	input_vector = get_input_direction()
	$Area2D.rotation = input_vector
	barra_de_vida.value = vida
	barra_de_enemigos.value = points
	if has_control or (has_mouse and not mobile_device):
		direction.x = Input.get_axis("mover_izquierda", "mover_derecha")
		direction.y = Input.get_axis("mover_arriba", "mover_abajo")
	else:
		direction = $ui_usuario/botones_telefono/Joystick_move.direccion
	if direction.x or direction.y:
		if can_attack and not hit:
			sprite.play("Walking")
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if direction.x == 0 and direction.y == 0 and can_attack and not hit:
		sprite.play("Idle")
	
	move_and_slide()
	GameOver()

func _input(event: InputEvent) -> void:
	if event.is_class("InputEventScreenDrag") and joystick.event_index == event.index and joystick.joystick_press:
		input_vector = get_input_direction(joystick.global_position.direction_to(event.position).normalized())
	if event.is_action_pressed("Attack"):
		if can_attack:
			$Espada.Attack(global_data.datos_usuario["damage"])
	if event.is_action_pressed("Disparar_arco"):
		if can_attack and global_data.inventario["arrow"] > 0:
			$Arco.disparar()
	if event.is_action_pressed("pausar_juego"):
		get_node("/root/Node2D/Menu/menu_pausa").visible = true
		get_node("/root/Node2D/Menu/menu_pausa/jugar").grab_focus(true)
		get_tree().paused = true
	if event.is_action_pressed("use_small_potion"):
		use_potion("small_potion", 3)
	if event.is_action_pressed("use_big_potion"):
		use_potion("big_potion", 5)
	if event.is_class("InputEventMouseMotion"):
		has_control = false
		has_mouse = true
	if event.is_class("InputEventJoypadMotion"):
		has_control = true
		has_mouse = false
	if event.is_class("InputEventScreenTouch"):
		has_control = false
		has_mouse = false

func GameOver() -> void:
	if vida <= 0 and not muerto:
		muerto = true
		$"../../../Sonidos/Musica de Muerte".play()
		global_data.GuardarArchivos()
		get_tree().paused = true
		get_node("/root/Node2D/Menu/menu_muerte").visible = true
		get_node("/root/Node2D/Menu/menu_muerte/ColorRect/AnimationPlayer").play("Fade in red")

func use_potion(potion:String, curacion:int) -> void:
	if global_data.inventario[potion] > 0:
		if vida == global_data.datos_usuario["max_vida"]:
			return
		elif vida + curacion > global_data.datos_usuario["max_vida"]:
			vida = global_data.datos_usuario["max_vida"]
		else:
			vida += curacion
		global_data.inventario[potion] -= 1

func _on_animated_sprite_2d_animation_finished() -> void:
	can_attack = true 
	hit = false
