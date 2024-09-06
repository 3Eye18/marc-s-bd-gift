extends CharacterBody2D

@onready var animation_tree = $AnimationTree

@export var SPEED: float = 20000

var can_move: bool = true


func _physics_process(delta):
	if DialogueManager.is_dialogue_active:
		can_move = false
	else:
		can_move = true
	
	if can_move:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		if direction == Vector2.ZERO:
			animation_tree.get("parameters/playback").travel("Idle")
		else:
			animation_tree.get("parameters/playback").travel("Walk")
			animation_tree.set("parameters/Idle/blend_position", direction)
			animation_tree.set("parameters/Walk/blend_position", direction)
		
		var speed: float = SPEED
		velocity = direction * speed * delta
		
		move_and_slide()
	else: 
		animation_tree.get("parameters/playback").travel("Idle")
