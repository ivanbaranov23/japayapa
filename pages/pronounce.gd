extends "res://pages/question_base.gd"


func check_answer(text):
	var data = await get_question_data()
	if data == {}:
		return false
	for hira in data.hiragana:
		if (text == hira)or(String_utils.translitterate(text) == String_utils.translitterate(hira)):
			#happy
			print("yay")
			play_sound(true)
			Global.register_answer(true, "pronounce")
			if Global.last_kanji_complition:
				show_info()
			return true
	#else:
	play_sound(false)
	show_info()
	return true
