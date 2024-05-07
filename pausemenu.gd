extends TouchScreenButton
var pausemenu = load("res://pausemenu.tscn").instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _pressed(event):
	get_tree().paused = true
	pausemenu = load("res://pausemenu.tscn").instantiate()
	get_tree().add_child(pausemenu)


func _on_play_gui_input(event):
	pausemenu.queue_free()
	get_tree().paused = false
