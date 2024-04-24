extends CharacterBody3D
var projectile = preload("res://projectile.tscn")
# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO
		
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	if Input.is_action_pressed("move_up"):
		direction.z -= 1
		
	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
		#$Pivot.look_at(position + direction, Vector3.UP)
		
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	# Moving the Character
	velocity = target_velocity
	move_and_slide()

func fireprojectile():
	var instance = projectile.instance() #unpacks the scene that is loaded in the preload function
	instance.position = Vector3(0, 2, 0) #set whatever position you need
	instance.linear_velocity = Vector3(0, 0, 0) #direction you want it to fire in
	$MainSceneNode.add_child(instance) #adds child to the 3d world
	print("spawned projectile")
