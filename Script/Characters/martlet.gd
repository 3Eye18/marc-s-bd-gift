extends CharacterBody2D

@export var speech_sound = preload("res://Asset/Sounds/Texts.wav")
@export var first_blend_position = Vector2(0, 1)
#@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var interaction_area = $"Interaction Area"
@onready var animation_tree = $AnimationTree

var lines: Array[Dictionary] = [
	{
		"line": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
		"sprite_name": "martlet_smug"
	}
]
var interacted: bool = false


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	animation_tree.set("parameters/Idle/blend_position", first_blend_position)


func _physics_process(delta):
	#check_direction_to_player()
	#
	#if interacted:
		#if DialogueManager.is_dialogue_active and !DialogueManager.can_advance_line:
			#animation_tree.get("parameters/playback").travel("Talk")
		#elif DialogueManager.is_dialogue_active and DialogueManager.can_advance_line:
			#animation_tree.set(
				#"parameters/Idle/blend_position", 
				#animation_tree.get("parameters/Talk/blend_position")
			#)
			#animation_tree.get("parameters/playback").travel("Idle")
	pass


func _on_interact():
	var initial_blend_position = animation_tree.get("parameters/Idle/blend_position")
	interacted = true
	
	DialogueManager.start_dialogue(Vector2(0, 508), lines, speech_sound)
	await DialogueManager.dialogue_finished
	
	interacted = false
	animation_tree.set("parameters/Idle/blend_position", initial_blend_position)


#func check_direction_to_player():
	## Calculate direction vector
	#var direction_vector = (player.get_node("CollisionShape2D").global_position - $"Interaction Area/CollisionShape2D".global_position).normalized()
	## Calculate angle between direction vector and forward direction
	#var angle = rad_to_deg(direction_vector.angle_to(Vector2.UP))
	#
	## Direction of the player to the interact area
	#if angle >= -45 and angle <= 45:
	## Up
		#animation_tree.set("parameters/Talk/blend_position", Vector2(0, -1))
	#elif angle > 45 and angle <= 135:
	## Left
		#animation_tree.set("parameters/Talk/blend_position", Vector2(-1, 0))
	#elif angle > 135 or angle <= -135:
	## Down
		#animation_tree.set("parameters/Talk/blend_position", Vector2(0, 1))
	#else:
	## Right
		#animation_tree.set("parameters/Talk/blend_position", Vector2(1, 0))
