extends CharacterBody3D
var projectile = preload("res://projectile.tscn")
var pausemen = preload("res://pausemenu.tscn")
# How fast the player moves in meters per second.
@export var speed = 14
@export var maxspeed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var camera_rotation_sensitivity = 0.002
@export var jump_impulse = 20
@export var proj_cooldown = 0
@export var damage = 0.05

var accelerationx = 0
var accelerationy = 0
var accelerationz = 0

var target_velocity = Vector3.ZERO
@onready var aimcast = $Yaw/Pitch/Camera/RayCast3D
@onready var muzzle = $Yaw/Pitch/GunMid/Muzzle
#@onready var crosshair = $Yaw/Pitch/Camera/Crosshair
@onready var Parameters = PhysicsRayQueryParameters3D.create(muzzle.transform.origin, aimcast.get_collision_point(),0b11111111_11111111_11111111_11111110)

func _ready():
	if(OS.get_name() != "Android"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#crosshair.position.x = get_viewport().size.x / 2 - 32
	#crosshair.position.y = get_viewport().size.y / 2 - 32

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
	if Input.is_action_pressed("click"):# && (OS.get_name() != "Android"):
		if aimcast.is_colliding():
			#printerr("A")
			#var bullet = get_world_3d().direct_space_state
			#var collision = bullet.intersect_ray(Parameters)
			#if not collision.is_empty():
				#printerr("B")
				#var target = collision["collider"]
				#if target.is_in_group("Enemy"):
					#printerr("C")
					#target.health -= damage
			var target = aimcast.get_collider()
			if target != null:
				if target.is_in_group("Enemy"):
					target.health -= damage
		fireprojectile()
	if Input.is_action_just_pressed("pause"):
		var pause = pausemen.instantiate()
		get_parent().add_child(pause)
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
		#movement_direction = direction.rotated(Vector3.RIGHT, $Yaw/Pitch.rotation.y)
		
	# Ground Velocity
	#target_velocity.x = direction.x * speed
	#target_velocity.z = direction.z * speed
	target_velocity.x = movement_direction.x * speed
	target_velocity.z = movement_direction.z * speed
	target_velocity.y = movement_direction.y * speed
	#if(target_velocity.x > maxspeed):
	#	target_velocity.x = maxspeed
	#if(target_velocity.z > maxspeed):
	#	target_velocity.z = maxspeed
	#if(target_velocity.y > maxspeed):
	#	target_velocity.y = maxspeed
	#if(target_velocity.x < -2):
	#	target_velocity.x = -2
	#if(target_velocity.z < -2):
	#	target_velocity.z = -2
	#if(target_velocity.y < -2):
	#	target_velocity.y = -2
	
	# Vertical Velocity
	#if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
	#	target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	# Moving the Character
	velocity = target_velocity
	#if is_on_floor() and Input.is_action_just_pressed("jump"):
	#	target_velocity.y = jump_impulse
	move_and_slide()

func _process(delta):
	proj_cooldown += 1

func fireprojectile():
	if proj_cooldown >= 500:
		var instance = projectile.instantiate() #unpacks the scene that is loaded in the preload function
		instance.position = Vector3(0, 2, 0) #set whatever position you need
		#instance.linear_velocity = Vector3(0, 0, -20) #direction you want it to fire in
		owner.add_child(instance) #adds child to the 3d world
		instance.position = $Yaw/Pitch/ShootPositionLeft.global_position
		#instance.rotate_y(90)
		#instance.rotate(Vector3(0, 1, 0), 90)
		instance.transform.basis = $Yaw/Pitch.global_transform.basis
		instance.apply_impulse(transform.basis.z, -transform.basis.z * speed)
		
		var instance2 = projectile.instantiate() #unpacks the scene that is loaded in the preload function
		instance2.position = Vector3(0, 2, 0) #set whatever position you need
		#instance2.linear_velocity = Vector3(0, 0, -20) #direction you want it to fire in
		owner.add_child(instance2) #adds child to the 3d world
		instance2.position = $Yaw/Pitch/ShootPositionRight.global_position
		#instance2.rotate_y(90)
		#instance2.rotate(Vector3(0, 1, 0), 90)
		instance2.transform.basis = $Yaw/Pitch.global_transform.basis
		instance2.apply_impulse(transform.basis.z, -transform.basis.z * 500)
		
		proj_cooldown = 0

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

func get_closest_enemy():
	var all_enemies = get_tree().get_nodes_in_group("Enemy")
	var closest_enemy = null
	
	if (all_enemies.size() > 0):
		closest_enemy = all_enemies[0]
		for player in all_enemies:
			var distance_to_this_player = global_position.distance_squared_to(player.global_position)
			var distance_to_closest_player = global_position.distance_squared_to(closest_enemy.global_position)
			if (distance_to_this_player < distance_to_closest_player):
				closest_enemy = player
 
	return closest_enemy
