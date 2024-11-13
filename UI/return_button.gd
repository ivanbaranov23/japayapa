extends Control

@export var scene : PackedScene = preload("res://UI/main_menu.tscn")

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_packed(scene)
