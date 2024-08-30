extends CharacterBody2D


@export var SPEED: float = 100


func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var speed: float = SPEED
	if Input.is_action_pressed("sprint"):
		speed = SPEED * 2
	
	velocity = direction * speed
	
	if velocity == Vector2.ZERO: 
			$AnimatedSprite2D.stop()
	if Input.is_action_pressed("sprint"):
		if velocity.x > 0 && velocity.y == 0:
			$AnimatedSprite2D.play("right_sprint", 1.5)
		elif velocity.x < 0 && velocity.y == 0:
			$AnimatedSprite2D.play("left_sprint", 1.5)
		elif velocity.x == 0 && velocity.y > 0:
			$AnimatedSprite2D.play("down_sprint", 1.5)
		elif velocity.x == 0 && velocity.y < 0:
			$AnimatedSprite2D.play("up_sprint", 1.5)
	else:
		if velocity.x > 0 && velocity.y == 0:
			$AnimatedSprite2D.play("right_walk")
		elif velocity.x < 0 && velocity.y == 0:
			$AnimatedSprite2D.play("left_walk")
		elif velocity.x == 0 && velocity.y > 0:
			$AnimatedSprite2D.play("down_walk")
		elif velocity.x == 0 && velocity.y < 0:
			$AnimatedSprite2D.play("up_walk")
	
	move_and_slide()
	
	
