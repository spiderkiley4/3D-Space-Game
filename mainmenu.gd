extends MarginContainer
game = load("res://space.tscn").instance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_gui_input(event):
	get_tree().get_root().queue_free()
	get_tree().get_root().add_child(game)
