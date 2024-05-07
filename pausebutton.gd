extends TouchScreenButton
var pausemenu = load("res://pausemenu.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed(event):
	get_tree().paused = true
	pausemenu = load("res://pausemenu.tscn").instantiate()
	get_tree().add_child(pausemenu)

