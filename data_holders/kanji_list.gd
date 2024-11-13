extends Resource
class_name Kanji_list

var kanjis = {}

func _init(file_name):
	var f = FileAccess.open(file_name, FileAccess.READ)
	if f.is_open():
		kanjis = JSON.parse_string(f.get_as_text())
