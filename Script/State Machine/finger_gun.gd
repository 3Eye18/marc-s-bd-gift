extends State


func physics_update(delta: float) -> void:
	owner.animation_tree.get("parameters/playback").travel("finger_gun")
	
	if !owner.finger_gun:
		state_machine.transition_to("Idle")
