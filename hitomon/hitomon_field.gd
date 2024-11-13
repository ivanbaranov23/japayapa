extends Node2D

@export var extend : Vector2

@export var buffer : int = 10

const Hitomon_scene = preload("res://hitomon/hitomon.tscn")

func _ready():
	add_hitomons.call_deferred(Global.get_hitomon_maps_for_display())

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("push"):
		$push_area.global_position = get_global_mouse_position()
		
		


func add_hitomons(hitomons_array): 
	for h in hitomons_array:
		add_hitomon_from_map(h)
		
		
func add_hitomon(hit):
	add_child(hit)
	hit.position = extend / 2 + get_random_pos() / 10.0
func add_hitomon_from_map(h, center : bool = false):
	var hit = Hitomon_scene.instantiate()
	add_child(hit)
	hit.set_textures.call_deferred(h)
	hit.position = extend / 2
	if !center:
		hit.position = get_random_pos()

func get_random_pos():
	return Vector2(randf_range(buffer, extend.x - buffer), randf_range(buffer, extend.y - buffer))
