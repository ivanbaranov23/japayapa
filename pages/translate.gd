extends "res://pages/question_base.gd"


func check_answer(text):
	
	var data = await get_question_data()
	if data == {}:
		return false
	
	for tr in data.get("translation", []):
		print(String_utils.strip(tr))
		if String_utils.check_for_typo(String_utils.strip(text), String_utils.strip(tr)):
			#happy
			
			play_sound(true)
			Global.register_answer(true, "translate")
			if Global.last_kanji_complition:
				show_info()
			return true
	#else:
	play_sound(false)
	show_info()
	return true
