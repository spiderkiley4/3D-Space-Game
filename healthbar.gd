extends Sprite3D
@export var maxhealth = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$SubViewport/ProgressBar.max_value = maxhealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
