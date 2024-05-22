extends MeshInstance3D

var alpha = 1.0
@onready var scrap = $GPUParticles3D
@onready var terrain = $GPUParticles3D2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(pos1,pos2):
	var draw_mesh = ImmediateMesh.new()
	mesh = draw_mesh
	draw_mesh.surface_begin(Mesh.PRIMITIVE_LINES,material_override)
	draw_mesh.surface_add_vertex(pos1)
	draw_mesh.surface_add_vertex(pos2)
	draw_mesh.surface_end()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	alpha -= delta * 3.5
	material_override.albedo_color.a = alpha

func trigger_particles(pos, gun_pos, on_enemy):
	if on_enemy:
		scrap.position = pos
		scrap.look_at(gun_pos)
		scrap.emitting = true
	else:
		terrain.position = pos
		terrain.look_at(gun_pos)
		terrain.emitting = true

func _on_timer_timeout():
	queue_free()
