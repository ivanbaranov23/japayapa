extends Node
class_name Data_answer_checker

func get_data(kanji): 
	var i = Global.kanji_holder.find_int(kanji)
	return Global.kanji_holder[i][kanji]
