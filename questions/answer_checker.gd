extends Node

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var response_timer: Timer = $response_timer

var last_kanji = ""
var last_data = {}
var status
@export var all_info = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#search_data("彼")
	#await data_found
	#search_data("動き")
	pass

signal data_found
func search_data(kanji):
	last_kanji = kanji
	var data = {
		"query": kanji,
		"language": "English",
		"no_english": false
	}
	status = http_request.request("https://jotoba.de/api/search/words", 
		["content-type: application/json", "accept: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify(data)
	)
	#print(status)
	if status != OK:
		print(status == ERR_CANT_CONNECT)
	else: 
		response_timer.start()

func get_data(kanji): 
	search_data(kanji)
	await data_found
	if status != OK:
		return {}
	return last_data

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	last_data = {}
	if result != HTTPRequest.RESULT_SUCCESS:
		print("fail")
	else:
		#print("found")
		var json = JSON.parse_string(body.get_string_from_utf8())
		if json:
			last_data["hiragana"] = []
			last_data["translation"] = []
			for a in json.words:
				#print(a)
				if !a.common: continue
				var kana = a.reading.get("kana", "")
				var kanji = a.reading.get("kanji", "")
				if (kana != last_kanji)and(kanji != last_kanji): continue
				last_data["hiragana"].append(String_utils.kata_to_hira(kana))
				last_data["kanji"] = kanji
				#print(kana)
				
				for b in a.senses[0].glosses:
					last_data.translation.append(b)
					
			
			
			last_data["all_translation"] = json.words
			
			
			
			#print()
		#print(json.words)
		#print(result)
		#print(response_code)
		#print(headers)
		
		#print(last_data.get("translation"))
		#last_data = Global.default_answer_response
	response_timer.stop()
	data_found.emit()


func _on_response_timer_timeout() -> void:
	print("failed")
	#failed
	http_request.cancel_request()
	
	last_data = {}
	data_found.emit()
