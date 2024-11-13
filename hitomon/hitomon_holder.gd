extends Resource
class_name Hitomon_holder

var hitomon_schemes = []



func get_hitomon_maps_for_display(max_number : int, factory : Hitomon_factory):
	var selected = hitomon_schemes.duplicate()
	while selected.size() > max_number:
		selected.pop_at(randi() % selected.size())
	
	for s in range(selected.size()):
		selected[s] = factory.get_hitomon_map(selected[s])
	return selected

func cost():
	return 3 + hitomon_schemes.size() * 2
