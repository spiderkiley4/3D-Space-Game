extends CharacterBody3D
var projectile = preload("res://projectile.tscn")
# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var camera_rotation_sensitivity = 0.01
@export var jump_impulse = 20

var target_velocity = Vector3.ZERO

func _ready():
	if(OS.get_name() != "Android"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
	if Input.is_action_pressed("jump"):
		direction.y += 1
	if Input.is_action_pressed("flydown"):
		direction.y -= 1
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
	# Vertical Velocity
	#if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
	#	target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	# Moving the Character
	velocity = target_velocity
	#if is_on_floor() and Input.is_action_just_pressed("jump"):
	#	target_velocity.y = jump_impulse
	move_and_slide()

func fireprojectile():
	var instance = projectile.instance() #unpacks the scene that is loaded in the preload function
	instance.position = Vector3(0, 2, 0) #set whatever position you need
	instance.linear_velocity = Vector3(0, 0, 0) #direction you want it to fire in
	$Main.add_child(instance) #adds child to the 3d world
	print("spawned projectile")

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
