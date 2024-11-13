extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var factory = load("res://hitomon/factory.tres")
	factory.load_all()
	ResourceSaver.save(factory, "res://hitomon/factory.tres")
	print("done")
