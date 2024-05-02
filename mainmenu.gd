extends MarginContainer
var game = load("res://space.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_gui_input(event):
	if Input.is_action_just_pressed("click") or (OS.get_name() == "Android"):
		hide()
		#get_tree().get_root().add_child(game)
		add_child(game)

func _on_quit_gui_input(event):
	get_tree().quit()
