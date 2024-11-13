extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_released("push"):
	if Input.is_action_pressed("push"):
		for a in get_overlapping_areas():
			var dp = a.global_position - global_position
			#dp = dp.normalized() * 9000 / (1 + dp.length()) + Vector2(randf_range(-1, 1) , randf_range(-1, 1)) * 10
			#a.position += dp * delta
			a.on_move(dp)
