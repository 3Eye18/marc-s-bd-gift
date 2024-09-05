extends CharacterBody2D


@export var SPEED: float = 20000
var can_move: bool = true


func _physics_process(delta):
	if can_move:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var new_position = self.global_position
		
		if direction == Vector2.ZERO:
			$AnimationTree.get("parameters/playback").travel("Idle")
		else:
			$AnimationTree.get("parameters/playback").travel("Walk")
			$AnimationTree.set("parameters/Idle/blend_position", direction)
			$AnimationTree.set("parameters/Walk/blend_position", direction)
		
		var speed: float = SPEED
		velocity = direction * speed * delta
		
		move_and_slide()
