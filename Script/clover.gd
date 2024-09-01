extends CharacterBody2D


@export var SPEED: float = 300


func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var speed: float = SPEED
	velocity = direction * speed
	
	if direction.x > 0 && direction.y == 0:
		$AnimatedSprite2D.play("right_walk")
	elif direction.x < 0 && direction.y == 0:
		$AnimatedSprite2D.play("left_walk")
	elif direction.x == 0 && direction.y < 0:
		$AnimatedSprite2D.play("up_walk")
	elif direction.x == 0 && direction.y > 0:
		$AnimatedSprite2D.play("down_walk")
	
	if direction == Vector2.ZERO: 
		$AnimatedSprite2D.stop()
	
	move_and_slide()
