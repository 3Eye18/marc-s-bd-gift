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
	
	if get_slide_collision_count():
		for i in get_slide_collision_count():
			var collider = get_slide_collision(i).get_collider()
			
			var player_collision_box = $CollisionShape2D
			var obstacle_collision_box = collider.get_node("CollisionShape2D")
			
			## Calculate positions
			#print("Player: ", player_collision_box.global_position.y, " Rock: ",obstacle_collision_box.global_position.y)
			var player_bottom = player_collision_box.global_position.y + player_collision_box.shape.size.y / 2
			var obstacle_top = obstacle_collision_box.global_position.y - obstacle_collision_box.shape.size.y * 4 /2
			#print("Bot: ", player_bottom, " Top: ",obstacle_top)
			
			## Adjust Z-index
			if player_bottom < obstacle_top:
				collider.z_index = 1
			else:
				collider.z_index = 0
