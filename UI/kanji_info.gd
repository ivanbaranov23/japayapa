extends ScrollContainer

var kanji : String = ""
var info

@onready var kanji_label: Label = $V/kanji
@onready var kana: Label = $V/kana/kana
@onready var romanji: Label = $V/kana/romanji
@onready var translation: VBoxContainer = $V/translation
@onready var translation_2: VBoxContainer = $V/translation2

@onready var answer_checker: Node = $answer_checker

const label_color = Color(0.75, 0.75, 0.75)

var displayed : bool = false
func display_kanji():
	if displayed: return
	displayed = true
	
	
	kanji_label.text = kanji
	info = await answer_checker.get_data(kanji)
	
	if info == {}: 
		print("aaaaaaaaaaaaaaaaaaaaaaaaa")
		return
	
	kana.text = ", ".join(info.get("hiragana", ["failed loading hira"]))
	
	var rom = []
	for hira in info.get("hiragana", []):
		rom.append(String_utils.translitterate(hira))
	romanji.text = ", ".join(rom)
	
	display_common_translation()
	display_all_translation()


func display_common_translation():
	for tr in info.get("translation", []):
		add_display_label(translation, " *" + tr)

func display_all_translation():
	for trans in info.all_translation:
		
		for i in trans.senses:
			var kanji = trans.reading.get("kanji", trans.reading.kana) + "\n" + trans.reading.get("hiragana", trans.reading.kana) + "\n"
			var transl = ""
			for p in i.pos:
				if p is String:
					kanji += "[" + p + "]"
				else:
					kanji += "[" + p.keys()[0] + "]"
			for w in i.glosses:
				transl += " *" + w + "\n"
			
			add_display_label(translation_2, kanji, false)
			add_display_label(translation_2, transl)


func add_display_label(node : Control, text : String, gray : bool = true):
	var l = Label.new()
	if gray: l.modulate = label_color
	l.autowrap_mode = TextServer.AUTOWRAP_WORD
	l.text = text
	node.add_child(l)
