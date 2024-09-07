extends State


func physics_update(delta: float) -> void:
	owner.animation_tree.get("parameters/playback").travel("Talk")
	
	if owner.interacted and DialogueManager.is_dialogue_active and DialogueManager.can_advance_line:
		owner.animation_tree.set(
				"parameters/Idle/blend_position", 
				owner.animation_tree.get("parameters/Talk/blend_position")
		)
		state_machine.transition_to("Idle")
