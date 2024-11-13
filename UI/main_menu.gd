extends Control

@onready var ready_label: Label = $V/P/Label

@onready var values = [
	$"V/GridContainer/1/value", 
	$"V/GridContainer/2/value", 
	$"V/GridContainer/3/value", 
	$"V/GridContainer/4/value", 
	$"V/GridContainer/5/value", 
	$"V/GridContainer/6/value", 
	$"V/GridContainer/7/value",
	$"V/GridContainer/8/value"
]

func _ready():
	Global.complited_this_run = 0
	ready_label.text = "Ready: " + str(Global.count_ready())
	
	var tiers = Global.count_tiers()
	for i in range(8):
		values[i].text = "lvl " + str(i + 1) + ": " + str(tiers[i])
	
	print(Global.user_progress.data)


func _on_start_pressed() -> void:
	Global.set_next_scene()


func _on_config_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/config_scene.tscn")


func _on_hitomon_pressed() -> void:
	get_tree().change_scene_to_file("res://hitomon/hitomon_display.tscn")
