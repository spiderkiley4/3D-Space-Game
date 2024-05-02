extends MarginContainer
var pausemenu = load("res://pausemenu.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if(Input.is_action_just_pressed("pause")):
		get_tree().paused = true
		pausemenu = load("res://pausemenu.tscn").instantiate()
		get_tree().add_child(pausemenu)


func _on_play_gui_input(event):
	pausemenu.queue_free()
	get_tree().paused = false
