extends Page_base


@onready var kanji: Label = $V/G/kanji
@onready var id: Label = $V/G/id

@onready var prononciation: Label = $V/P/prononciation
@onready var translation: Label = $V/P2/translation


var question : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	question = Global.current_question
	coins.text = str(69)
	kanji.text = question
	id.text = str(Global.current_question_id)
	
	var info = await Global.get_question_data()
	
	#check for failure
	if !("hiragana" in info) or !("translation" in info):
		print("failed ", question)
		Global.user_progress.kanji_left.erase(question)
		if question in Global.user_progress.data:
			Global.user_progress.data.erase(question)
		Global.set_next_scene()
		return
	
	prononciation.text = ", ".join(info.hiragana)#", "failed")
	translation.text = ", ".join(info.translation)


func _on_next_pressed() -> void:
	Global.register_learned()
	Global.set_next_scene()
