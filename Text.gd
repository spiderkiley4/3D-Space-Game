extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func mouse_entered():
	add_theme_color_override("default_color", Color.SKY_BLUE)

func mouse_exited():
	add_theme_color_override("default_color", Color.WHITE)
