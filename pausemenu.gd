extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if(Input.is_action_just_pressed("pause")):
		get_tree().paused = !(get_tree().paused)
		if(get_tree().paused == true):
			show()
		if(get_tree().paused == false):
			hide()


func _on_play_gui_input(event):
	hide()
	get_tree().paused = false
