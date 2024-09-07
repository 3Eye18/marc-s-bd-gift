extends State

@onready var player = get_tree().get_nodes_in_group("player")[0]

func physics_update(delta: float) -> void:
	check_direction_to_player()
	owner.animation_tree.get("parameters/playback").travel("Idle")
	
	if owner.velocity != Vector2.ZERO:
		state_machine.transition_to("Walk")
	elif owner.interacted and DialogueManager.is_dialogue_active and !DialogueManager.can_advance_line:
		state_machine.transition_to("Talk")


func check_direction_to_player():
	# Calculate direction vector
	var direction_vector = (player.get_node("CollisionShape2D").global_position - owner.get_node("Interaction Area/CollisionShape2D").global_position).normalized()
	# Calculate angle between direction vector and forward direction
	var angle = rad_to_deg(direction_vector.angle_to(Vector2.UP))
	
	# Direction of the player to the interact area
	if angle >= -45 and angle <= 45:
	# Up
		owner.animation_tree.set("parameters/Talk/blend_position", Vector2(0, -1))
	elif angle > 45 and angle <= 135:
	# Left
		owner.animation_tree.set("parameters/Talk/blend_position", Vector2(-1, 0))
	elif angle > 135 or angle <= -135:
	# Down
		owner.animation_tree.set("parameters/Talk/blend_position", Vector2(0, 1))
	else:
	# Right
		owner.animation_tree.set("parameters/Talk/blend_position", Vector2(1, 0))
