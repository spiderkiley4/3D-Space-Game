extends Node

@export var enemy_scene: PackedScene

func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = get_node("SpawnPath/SpawnLocation")
	enemy_spawn_location.progress_ratio = randf()
	var player_position = $Player.position
	enemy.initialize(enemy_spawn_location.position, player_position)
	add_child(enemy)
	enemy.killed.connect($ScoreLabel._on_enemy_killed.bind())


