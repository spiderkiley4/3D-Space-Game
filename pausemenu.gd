extends MarginContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _ready():
	get_tree().paused = true
	if(OS.get_name() != "Android"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_gui_input(event):
	if Input.is_action_just_pressed("click") or (OS.get_name() == "Android"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = false
		queue_free()
func _input(event):
	if Input.is_action_just_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = false
		queue_free()
