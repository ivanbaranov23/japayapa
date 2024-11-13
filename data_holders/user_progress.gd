extends Resource
class_name User_progress

#data[kanji] = {
#	time = 11
#	question = {
#		translation = false
#		prononciation = true
#	}
#}
const default_data_point = {
	"tier": 0,
	"time": 0,
	"learned": false,
	"learned_time": 0,
	"question": {
		"translate": false,
		"pronounce": false
	}
}
var data : Dictionary = {}
var kanji_left = []

var coins = 10

func create():
	var f = FileAccess.open("res://backup_data/all_words.json", FileAccess.READ)
	kanji_left = JSON.parse_string(f.get_as_text())

func make(d : Dictionary):
	data = d.get("data", {})
	for kanji in data:
		data[kanji].merge(default_data_point)
	kanji_left = d.get("kanji", [])
	coins = d.get("coins", 10)


func reset_kanji_list():
	var f = FileAccess.open("res://backup_data/all_words.json", FileAccess.READ)
	kanji_left = JSON.parse_string(f.get_as_text())
	for kanji in data:
		kanji_left.erase(kanji)
