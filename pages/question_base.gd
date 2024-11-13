extends Page_base

#@onready var coins: Label = $V/H/P/coins
@onready var input: LineEdit = $V/H2/input
@onready var question_label: Label = $V/T/question
@onready var send_button: TextureButton = $V/H2/TextureButton

@onready var info: TextureButton = $V/info

var question : String
enum States {
	idle,
	after_answer,
	thinking,
	failed
}
var state : States = States.idle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	question = Global.current_question
	#coins.text = str(69)
	question_label.text = question
	
	input.grab_focus()
	


func check_answer(_text) -> bool:
	return true
func get_question_data():
	return await Global.get_question_data()

func play_sound(correct):
	if correct:
		$correct.play()
		input.modulate = Color.GREEN
	else:
		$incorrect.play()
		input.modulate = Color.RED

func on_text_inputed_changed(_text) -> void:
	check_answer_routine()


func _on_texture_button_pressed() -> void:
	check_answer_routine()

func check_answer_routine():
	match state:
		States.idle: 
			input.editable = false
			send_button.disabled = true
			state = States.thinking
			
			var success = await check_answer(input.text)
			
			if success:
				state = States.after_answer
				send_button.disabled = false
				
				
				if Global.check_for_complition(question):
					show_info()
			else:
				state = States.failed
				$no_internet.show()
		States.after_answer:
			Global.set_next_scene()

func show_info():
	info.modulate = Color.WHITE
	info.disabled = false
