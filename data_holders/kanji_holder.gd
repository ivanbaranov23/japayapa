extends Resource
class_name Kanji_holder

var lists : Array[Kanji_list] = []


func add_list(l : Kanji_list):
	lists.push_back(l)

func find_int(kanji):
	for i in range(lists.size()):
		if kanji in lists[i].kanjis:
			return i
	return lists.size()
func find_n5to1(kanji) -> int:
	return lists.size() - find_int(kanji)
