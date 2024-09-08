extends CharacterBody2D

@export var speech_sound = preload("res://Asset/Sounds/Texts.wav")
@export var first_blend_position = Vector2(0, 1)
@onready var interaction_area = $"Interaction Area"
@onready var animation_tree = $AnimationTree

var lines: Array[Dictionary] = [
	{
		"line": "egassem drawkcaB",
		"sprite_name": "mooch_smug"
	}
]
var direction = Vector2.ZERO
var interacted: bool = false


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	animation_tree.set("parameters/Idle/blend_position", first_blend_position)


func _physics_process(delta):
	pass


func _on_interact():
	var initial_blend_position = animation_tree.get("parameters/Idle/blend_position")
	interacted = true
	
	DialogueManager.start_dialogue(DialogueManager.bottom_text, lines, speech_sound)
	await DialogueManager.dialogue_finished
	
	interacted = false
	animation_tree.set("parameters/Idle/blend_position", initial_blend_position)
