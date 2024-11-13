extends Control

const jotoba = preload("res://questions/answer_checker.tscn")

func _ready() -> void:
	randomize()
	load_all.call_deferred()

func load_all() -> void:
	load_config()
	load_user_progress()
	load_kanji()
	load_hitomons()
	load_answer_checkers()
	
	#Global.current_question = "誰"
	get_tree().change_scene_to_packed(preload("res://UI/main_menu.tscn"))
	#Global.set_next_scene()

func load_config() -> void:
	Global.config = load_json(Global.config_path)
	pass
func load_user_progress() -> void:
	var raw_progress = load_json(Global.user_progress_path)
	
	
	Global.user_progress = User_progress.new()
	Global.user_progress.make(raw_progress)
	if raw_progress == {}:
		Global.user_progress.create()
func load_kanji():
	Global.kanji_holder = Kanji_holder.new()
	for i in Global.kanji_path:
		Global.kanji_holder.add_list(Kanji_list.new(i))
func load_hitomons():
	var hito = load_json(Global.hitomon_path)
	Global.hitomon_holder = Hitomon_holder.new()
	Global.hitomon_holder.hitomon_schemes = hito.get("hitomons", [])
	
	Global.hitomon_factory = load("res://hitomon/factory.tres")
func load_answer_checkers():
	var j = jotoba.instantiate()
	Global.add_child(j)
	Global.answer_checkers.push_back(j)
	
	


func load_json(path) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	if file and file.is_open():
		return JSON.parse_string(file.get_as_text())
	return {}
