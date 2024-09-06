extends CharacterBody2D

@onready var speech_sound = preload("res://Asset/Sounds/Talk Martlet.wav")
@onready var interaction_area = $"Interaction Area"
@onready var animation_tree = $AnimationTree

var lines: Array[String] = [
	"Hey Clover! Happy Birthday!",
	"How's life in Snowdin so far?",
	"I hope it's not too cold in here for you.",
	"You can always move in my house if you want to.",
	"The Dune might be dry and hot but...",
	"If you can take the Furnace heat, you can take the Dune's."
]
var interacted: bool = false


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _physics_process(delta):
	if interacted:
		if DialogueManager.is_dialogue_active and !DialogueManager.can_advance_line:
			animation_tree.get("parameters/playback").travel("Talk")
		elif DialogueManager.is_dialogue_active and DialogueManager.can_advance_line:
			animation_tree.set(
				"parameters/Idle/blend_position", 
				animation_tree.get("parameters/Talk/blend_position")
			)
			animation_tree.get("parameters/playback").travel("Idle")


func _on_interact():
	var initial_blend_position = animation_tree.get("parameters/Idle/blend_position")
	interacted = true
	
	if interaction_area.direction == "left":
		animation_tree.set("parameters/Talk/blend_position", Vector2(-1, 0))
	if interaction_area.direction == "right":
		animation_tree.set("parameters/Talk/blend_position", Vector2(1, 0))
	if interaction_area.direction == "up":
		animation_tree.set("parameters/Talk/blend_position", Vector2(0, 1))
	if interaction_area.direction == "down":
		animation_tree.set("parameters/Talk/blend_position", Vector2(0, -1))
		
	DialogueManager.start_dialogue(Vector2(0, 0), lines, speech_sound)
	await DialogueManager.dialogue_finished
	
	interacted = false
	animation_tree.set("parameters/Idle/blend_position", initial_blend_position)
