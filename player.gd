extends CharacterBody3D
var projectile = preload("res://projectile.tscn")
# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var camera_rotation_sensitivity = 0.002
@export var jump_impulse = 20

var accelerationx = 0
var accelerationy = 0
var accelerationz = 0

var target_velocity = Vector3.ZERO

func _ready():
	if(OS.get_name() != "Android"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var direction = Vector3.ZERO
		
	if Input.is_action_pressed("move_right"):
		accelerationx += 0.020
		if accelerationx > 1.5:
			accelerationx = 1.5
	if Input.is_action_pressed("move_left"):
		accelerationx -= 0.020
		if accelerationx < -1.5:
			accelerationx = -1.5
	if Input.is_action_pressed("move_down"):
		accelerationz += 0.020
		if accelerationz > 1.5:
			accelerationz = 1.5
	if Input.is_action_pressed("move_up"):
		accelerationz -= 0.020
		if accelerationz < -1.5:
			accelerationz = -1.5
	if Input.is_action_pressed("jump"):
		accelerationy += 0.025
		if accelerationy > 0.5:
			accelerationy = 0.5
	if Input.is_action_pressed("flydown"):
		accelerationy -= 0.025
		if accelerationy < -0.5:
			accelerationy = -0.5
	if Input.is_action_pressed("click"):
		fireprojectile()
	direction.x += accelerationx
	direction.z += accelerationz
	direction.y += accelerationy
	
	if (accelerationx > 0 && !Input.is_action_just_pressed("move_right")):
		accelerationx -= 0.005
	if (accelerationx < 0 && !Input.is_action_just_pressed("move_left")):
		accelerationx += 0.005
	if (accelerationz > 0 && !Input.is_action_just_pressed("move_down")):
		accelerationz -= 0.005
	if (accelerationz < 0 && !Input.is_action_just_pressed("move_up")):
		accelerationz += 0.005
	if (accelerationy > 0 && !Input.is_action_just_pressed("jump")):
		accelerationy -= 0.005
	if (accelerationy < 0 && !Input.is_action_just_pressed("flydown")):
		accelerationy += 0.005
	
	
	var movement_direction = Vector3()
	if direction != Vector3.ZERO:
		#direction = direction.normalized()
		#$Yaw.look_at(position + direction, Vector3.UP)
		movement_direction = direction.rotated(Vector3.UP, $Yaw.rotation.y)
		
	# Ground Velocity
	#target_velocity.x = direction.x * speed
	#target_velocity.z = direction.z * speed
	target_velocity.x = movement_direction.x * speed
	target_velocity.z = movement_direction.z * speed
	target_velocity.y = movement_direction.y * speed
	# Vertical Velocity
	#if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
	#	target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	# Moving the Character
	velocity = target_velocity
	#if is_on_floor() and Input.is_action_just_pressed("jump"):
	#	target_velocity.y = jump_impulse
	move_and_slide()

func fireprojectile():
	var instance = projectile.instantiate() #unpacks the scene that is loaded in the preload function
	instance.position = Vector3(0, 2, 0) #set whatever position you need
	instance.linear_velocity = Vector3(0, 0, -10) #direction you want it to fire in
	add_child(instance) #adds child to the 3d world
	printerr("spawned projectile")

func _input(event):
	#if Input.is_key_pressed(KEY_J):
		#rotate_y(0.1)
	#if Input.is_action_just_pressed("pause"):
	#	get_tree().paused = !(get_tree().paused)
	#if(OS.get_name() != "Android"):
	if event is InputEventMouseMotion:
		var camera_rotation = event.relative * camera_rotation_sensitivity
		# "yaw" is the term for side-to-side turning of the camera (around a vertical axis)
		$Yaw.rotate(Vector3.DOWN, camera_rotation.x)
		# "pitch" is the term for up-and-down movement of the camera (around a horizontal axis)
		$Yaw/Pitch.rotate(Vector3.LEFT, camera_rotation.y)
