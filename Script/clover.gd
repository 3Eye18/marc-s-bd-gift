extends CharacterBody2D


@export var SPEED: float = 15000


func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	
	if direction == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", direction)
		$AnimationTree.set("parameters/Walk/blend_position", direction)
	
	
	
	var speed: float = SPEED
	velocity = direction * speed * delta
	
	move_and_slide()
