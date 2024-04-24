extends CharacterBody3D

@export var min_speed = 10
@export var max_speed = 18

func _physics_process(delta):
	move_and_slide()

func initialize(start_position, player_positio
