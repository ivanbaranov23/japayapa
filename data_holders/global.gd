extends Node

const user_progress_path = "user://user_progress.json"
var user_progress : User_progress
const tier_time_intervals = [
	-1,
	60 * 5,
	60 * 60,
	60 * 60 * 24,
	60 * 60 * 24 * 3,
	60 * 60 * 24 * 10,
	60 * 60 * 24 * 30,
	60 * 60 * 24 * 60
]

#settings

const kanji_path = [
	"res://backup_data/n5.json",
	"res://backup_data/n4.json",
	"res://backup_data/n3.json",
	"res://backup_data/n2.json",
	"res://backup_data/n1.json"
]
var kanji_holder : Kanji_holder

var current_question : String
var current_question_id : int

var answer_checkers = []
const default_answer_response = {
	"trasnlation": [],
	"prononciation": []
}
const question_scenes = {
	"learn": preload("res://pages/learn.tscn"),
	"translate": preload("res://pages/translate.tscn"),
	"pronounce": preload("res://pages/pronounce.tscn")
}

var started_kanji = []
var last_kanji_complition = false

const config_path = "user://config.json"
var config : Dictionary = {
	
}

const hitomon_path = "user://hitomon.json"
var hitomon_holder : Hitomon_holder
var hitomon_factory : Hitomon_factory


func register_learned():
	user_progress.data[current_question].learned = true
	if user_progress.data[current_question].learned_time == 0:
		user_progress.data[current_question].learned_time = Time.get_unix_time_from_system()
	if !(current_question in started_kanji):
		started_kanji.append(current_question)
func register_answer(correct, question_type):
	last_kanji_complition = false
	if !(current_question in user_progress.data):
		user_progress.data[current_question] = User_progress.default_data_point.duplicate(true)
	else:
		user_progress.data[current_question].merge(User_progress.default_data_point)
	
	if correct:
		user_progress.coins += 1
		user_progress.data[current_question].question[question_type] = true
		user_progress.data[current_question].time = Time.get_unix_time_from_system()
		last_kanji_complition = check_for_complition(current_question)
		if check_for_complition(current_question):
			complited_this_run += 1
			var t = user_progress.data[current_question].tier
			user_progress.data[current_question].question = User_progress.default_data_point.question.duplicate()
			user_progress.data[current_question].tier = min(t + 1, tier_time_intervals.size() - 1)
			started_kanji.erase(current_question)
		else:
			if !(current_question in started_kanji):
				started_kanji.append(current_question)
	else:
		reset_kanji_progress(current_question)
		
	user_progress.data[current_question].time = Time.get_unix_time_from_system()
func check_for_complition(kanji):
	
	return user_progress.data[kanji].question.translate and user_progress.data[kanji].question.pronounce
func reset_kanji_progress(kanji):
	if !(kanji in started_kanji):
		started_kanji.append(kanji)
	var lt = user_progress.data[current_question].learned_time
	user_progress.data[current_question] = User_progress.default_data_point.duplicate(true)
	user_progress.data[current_question].learned_time = lt



func set_next_scene() -> void:
	#print(user_progress.data)
	save_all()
	current_question = get_next_question()
	print(current_question)
	get_tree().change_scene_to_packed(get_next_question_scene())
func get_next_question():
	if (started_kanji.size() != 0)and(randf() < 0.3 + 0.1 * started_kanji.size()):
		print("from started")
		return started_kanji.pick_random()
	
	var possible = []
	for kanji in user_progress.data.keys(): 
		if (Time.get_unix_time_from_system() - user_progress.data[kanji].time) > tier_time_intervals[user_progress.data[kanji].tier]:
			if !(kanji in started_kanji):
				possible.append(kanji)
	if possible != []:
		print(possible)
		return possible.pick_random()
	
	
	print("selecting new")
	#return "実車"
	var prob = 1.0 - randf() ** (1.0 / config.get("commonality", 20))
	var id : int = int(prob * user_progress.kanji_left.size()) % user_progress.kanji_left.size()
	current_question_id = id
	return user_progress.kanji_left[id]
func get_next_question_scene() -> PackedScene:
	if !(current_question in user_progress.data):
		user_progress.data[current_question] = User_progress.default_data_point.duplicate(true)
	if (!user_progress.data[current_question].learned) and (user_progress.data[current_question].tier <= 0):
		return question_scenes.learn
	
	var possible = []
	if !user_progress.data[current_question].question.translate:
		possible.append(question_scenes.translate)
	if !user_progress.data[current_question].question.pronounce:
		possible.append(question_scenes.pronounce)
	
	return possible.pick_random()
func select_new_kanji():
	pass

var complited_this_run = 0
func count_ready():
	var t = Time.get_unix_time_from_system()
	var count = 0
	for kanji in user_progress.data:
		var tier = user_progress.data[kanji].tier
		if (t - user_progress.data[kanji].time) > tier_time_intervals[tier]:
			if !(kanji in started_kanji):
				count += 1
	return count
func count_tiers():
	var tiers = [0, 0, 0, 0, 0, 0, 0, 0]
	for kanji in user_progress.data:
		tiers[user_progress.data[kanji].tier] += 1
	return tiers


var gotten_data = {}
func get_question_data():
	if current_question in gotten_data:
		return gotten_data[current_question]
	
	for ch in answer_checkers:
		var adata
		adata = await ch.get_data(current_question)
		if adata != {}:
			gotten_data[current_question] = adata
			return adata
	return {}


func add_new_hitomon():
	var scheme = hitomon_factory.get_new_hitomon_scheme()
	hitomon_holder.hitomon_schemes.append(scheme)
	var map = hitomon_factory.get_hitomon_map(scheme)
	return map
func get_hitomon_maps_for_display():
	return hitomon_holder.get_hitomon_maps_for_display(config.get("hitomon_max_number", 20), hitomon_factory)



func save_all():
	save_user_progress()
	save_config()
	save_hitomons()
func save_user_progress():
	save(user_progress_path, {
		"data": user_progress.data,
		"kanji": user_progress.kanji_left,
		"coins": user_progress.coins
	})
func save_config():
	save(config_path, config)
func save_hitomons():
	save(hitomon_path, {
		"hitomons": hitomon_holder.hitomon_schemes
	})

func save(file_name, data):
	var file = FileAccess.open(file_name, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
