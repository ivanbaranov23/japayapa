extends Node

@onready var answer_checker: Node = $answer_checker

func _ready() -> void:
	check.call_deferred()

const a = 0
const b = 10000

func check():
	var f = FileAccess.open("res://backup_data/all_words.json", FileAccess.READ)
	var list = JSON.parse_string(f.get_as_text())
	f.close()
	var new_list = []
	
	for i in range(a, b):
		print(i)
		if await check_one(list[i]):
			new_list.append(list[i])
	
	var f_new = FileAccess.open("res://backup_data/all_words_new.json", FileAccess.WRITE)
	f_new.store_string(JSON.stringify(new_list))
	f_new.close()
	print("difference ", list.size(), " ", new_list.size(), ", ", list.size() - new_list.size())
func check_one(kanji):
	var data = await answer_checker.get_data(kanji)
	if !("translation" in data):
		print(kanji)
		return false
	return true
