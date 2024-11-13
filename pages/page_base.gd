extends Control
class_name Page_base

@onready var popup_panel = $PopupPanel
@onready var kanji_info: ScrollContainer = $PopupPanel/Control/kanji_info

@onready var stat: Label = $V/H/stat
@onready var coins: Label = $V/H/P/coins


func _ready() -> void:
	stat.text = "r " + str(Global.count_ready()) + " s " + str(Global.started_kanji.size()) + " c " + str(Global.complited_this_run)
	coins.text = str(Global.user_progress.coins)

func _on_info_pressed() -> void:
	popup_panel.show()
	kanji_info.kanji = Global.current_question
	kanji_info.display_kanji()


func _on_popup_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		popup_panel.hide()
