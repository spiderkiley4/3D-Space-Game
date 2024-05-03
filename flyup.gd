extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_name() != "Android"):
		hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	Input.action_press("jump")
