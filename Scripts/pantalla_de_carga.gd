extends CanvasLayer

var progreso:Array = []

func _ready() -> void:
	$Panel/Label/AnimationPlayer.play(tr("label_carga"))
	ResourceLoader.load_threaded_request("res://Escenas/mundo.tscn")

func _process(_delta: float) -> void:
	ResourceLoader.load_threaded_get_status("res://Escenas/mundo.tscn", progreso)
	$Panel/ProgressBar.value = progreso[0]*100
	if progreso[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get("res://Escenas/mundo.tscn")
		get_tree().change_scene_to_packed(packed_scene)
