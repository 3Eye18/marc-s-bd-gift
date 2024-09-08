extends State

func physics_update(delta: float) -> void:
	print("pos: ", owner.global_position)
	owner.move_and_slide()
	owner.animation_tree.get("parameters/playback").travel("Walk")
	owner.animation_tree.set("parameters/Walk/blend_position", owner.direction)
	owner.animation_tree.set("parameters/Idle/blend_position", owner.direction)
	
	if owner.velocity == Vector2.ZERO:
		state_machine.transition_to("Idle")
