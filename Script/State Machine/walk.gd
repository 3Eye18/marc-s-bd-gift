extends State


func physics_update(delta: float) -> void:
	owner.animation_tree.get("parameters/playback").travel("Walk")
	
	if owner.velocity == Vector2.ZERO:
		state_machine.transition_to("Idle")
