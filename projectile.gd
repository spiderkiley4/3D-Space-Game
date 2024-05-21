extends RigidBody3D

@export var speed = 70
@export var damage = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position += transform.basis * Vector3(0, 0, -speed) * delta
	pass

func _area_entered():
	queue_free()


func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= damage
		queue_free()
	else:
		#queue_free()
		pass
