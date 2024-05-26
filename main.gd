extends Node

@export var enemy_scene: PackedScene
@export var enemy_scene2: PackedScene
@export var enemy_sceneboss: PackedScene

func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy2 = enemy_scene2.instantiate()
	var enemy_spawn_location = get_node("SpawnPath/SpawnLocation")
	enemy_spawn_location.progress_ratio = randf()
	var player_position = $Player.position
	enemy.initialize(enemy_spawn_location.position, player_position)
	enemy2.initialize(enemy_spawn_location.position, player_position)
	add_child(enemy)
	add_child(enemy2)
	enemy.killed.connect($ScoreLabel._on_enemy_killed.bind())
	enemy2.killed.connect($ScoreLabel._on_enemy_killed.bind())




func _on_enemy_boss_timer_timeout():
	var enemyboss = enemy_sceneboss.instantiate()
	var enemy_spawn_locationboss = Vector3(0,2.5,0)
	var player_position = $Player.position
	enemyboss.initialize(enemy_spawn_locationboss, player_position)
	add_child(enemyboss)
	enemyboss.killed.connect($ScoreLabel._on_enemy_killed.bind())
