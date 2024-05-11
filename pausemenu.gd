extends MarginContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_play_gui_input(event):
	$pausemenu.queue_free()
	get_tree().paused = false
