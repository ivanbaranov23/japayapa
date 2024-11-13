extends Control

@onready var coins = $V/H1/P/coins
@onready var cost = $V/H2/Panel/cost

@export var cheat_mode : bool = false

func _ready():
	update_coins()

func update_coins():
	coins.text = str(Global.user_progress.coins)
	cost.text = str(Global.hitomon_holder.cost())


func _on_return_pressed():
	Global.save_progress()
	get_tree().change_scene_to_file.call_deferred("res://src/main_menu.tscn")



func _on_add_pressed():
	if cheat_mode or (Global.user_progress.coins >= Global.hitomon_holder.cost()):
		$V/C1/Hbar.value = 900/2*1.5-180
		_on_hbar_scrolling()
		Global.user_progress.coins -= Global.hitomon_holder.cost()
		$V/C1/Hbar/Hitomon_field.add_hitomon_from_map(Global.add_new_hitomon())
		Global.save_all()
		update_coins()


func _on_hbar_scrolling() -> void:
	$V/C1/Hbar/Hitomon_field.position.x = 200 - $V/C1/Hbar.value
	
