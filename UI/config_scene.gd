extends Control
@onready var commonality: HSlider = $V/HBoxContainer/commonality


func _ready() -> void:
	commonality.value = Global.config.get("commonality", 20)
	


func _on_button_1_pressed() -> void:
	Global.user_progress = User_progress.new()
	Global.user_progress.create()
	

func _on_button_2_pressed() -> void:
	Global.user_progress.reset_kanji_list()


func _on_commonality_value_changed(value: float) -> void:
	Global.config["commonality"] = value
	Global.save_config()
