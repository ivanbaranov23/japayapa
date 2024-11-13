extends Node2D

@onready var body = $body
@onready var hat = $body/hat
@onready var eyes = $body/face/eyes
@onready var nose = $body/face/nose
@onready var mouth = $body/face/mouth
@onready var arm_1 = $body/arm1
@onready var arm_2 = $body/arm2
@onready var leg_1 = $leg1
@onready var leg_2 = $leg2

#scheme -> leg: test.png
#map -> leg: texture


var state : int = 0
const states = {
	"idle": 0,
	"wander": 1,
	"happy": 2
}
const state_map = {
	0: 1,
	1: 0,
	2: 0
}

var goal : Vector2
const speed = 100.0
var tween : Tween
var velocity = Vector2.ZERO

var textures_map

func _ready():
	state = randi() % 2
	on_state_changed.call_deferred()
	if textures_map:
		set_textures(textures_map)

func _physics_process(delta: float) -> void:
	velocity *= pow(0.15, delta)
	position += velocity * delta

func set_textures(texture_dict):
	$body.texture = texture_dict.body
	$body/hat.texture = texture_dict.hat
	$body/face/eyes.texture = texture_dict.eyes
	$body/face/nose.texture = texture_dict.nose
	$body/face/mouth.texture = texture_dict.mouth
	$body/arm1.texture = texture_dict.arm
	$body/arm2.texture = texture_dict.arm
	$leg1.texture = texture_dict.leg
	$leg2.texture = texture_dict.leg

func on_state_changed():
	match state:
		states.idle:
			$timer.start(randf_range(2.0, 12.0))
			set_animation("idle")
		states.wander:
			goal = get_parent().get_random_pos()
			if tween:
				tween.kill()
			tween = create_tween()
			tween.tween_property(self, "position", goal, (goal - position).length() / speed)
			scale.x = sign((goal - position).x)
			$timer.start((goal - position).length() / speed)
			set_animation("walk")
		states.happy:
			$timer.start(randf_range(3.0, 5.0))
			$Bubble/Emotions.frame = randi() % 4
			set_animation("happy")

func set_animation(anim):
	$AnimationPlayer.play("RESET")
	$Bubble.visible = false
	$AnimationPlayer.play.call_deferred(anim)

func _on_timer_timeout():
	if state == states.idle:
		if (randf() > 0.9): state = states.happy
		else: state = states.wander
	else: state = state_map.get(state)
	on_state_changed()


func on_move(dir):
	state = states.idle
	velocity = dir.normalized() * 100
	if tween: tween.kill()
	on_state_changed()
	scale.x = sign(dir.x)
