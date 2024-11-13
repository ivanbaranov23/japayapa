extends Resource
class_name Hitomon_factory

@export var textures : Dictionary = {}

const body_parts = ["body", "eyes", "nose", "mouth", "hat", "arm", "leg"]

func _init():
	load_all()

func load_all():
	textures = {}
	for part in body_parts:
		textures[part] = Mass_loader.load("res://art/hitomon/" + part + "/", ".png")


func get_hitomon_map(texture_scheme):
	var map = {}
	for part in body_parts:
		map[part] = textures[part][texture_scheme[part]]
	return map

func get_new_hitomon_scheme():
	var texture_dict = {}
	for part in body_parts:
		texture_dict[part] = textures[part].keys().pick_random()
	return texture_dict
