extends CharacterBody2D

@export var speech_sound = preload("res://Asset/Sounds/Texts.wav")
@export var first_blend_position = Vector2(0, 1)
@onready var interaction_area = $"Interaction Area"
@onready var animation_tree = $AnimationTree

var direction = Vector2.ZERO
var interacted: bool = false
var heater_interacted = false
var interact_count: int = 0

var lines_0: Array[Dictionary] = [
	{
		"line": "Hey Clover! Enjoying the party so far?",
		"sprite_name": "martlet_normal_1"
	},
	{
		"line": "Really? So human's party is a lot like monster's",
		"sprite_name": "martlet_happy_1"
	}
]

var lines_1: Array[Dictionary] = [
	{
		"line": "By the way, Clover,",
		"sprite_name": "martlet_normal_2"
	},
	{
		"line": "tell me more about this \"travel\" UGPS option.",
		"sprite_name": "martlet_normal_1"
	},
	{
		"line": "How does it feel to fly in a cute small basket?",
		"sprite_name": "martlet_happy_1"
	}
]

var lines_heater: Array[Dictionary] = [
	{
		"line": "Yes, Clover?",
		"sprite_name": "martlet_normal_1"
	},
	{
		"line": "Oh, that heater?",
		"sprite_name": "martlet_normal_3"
	},
	{
		"line": "It was one of my first project with Chujin.",
		"sprite_name": "martlet_normal_3"
	},
	{
		"line": "This brings me back some memories.",
		"sprite_name": "martlet_sad_1"
	}
]


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	animation_tree.set("parameters/Idle/blend_position", first_blend_position)


func _physics_process(delta):
	pass


func _on_interact():
	var initial_blend_position = animation_tree.get("parameters/Idle/blend_position")
	interacted = true
	
	if heater_interacted:
		DialogueManager.start_dialogue(DialogueManager.bottom_text, lines_heater, speech_sound)
		heater_interacted = false
	else:
		match interact_count:
			0:
				DialogueManager.start_dialogue(DialogueManager.bottom_text, lines_0, speech_sound)
				interact_count += 1
			_:
				DialogueManager.start_dialogue(DialogueManager.bottom_text, lines_1, speech_sound)
	await DialogueManager.dialogue_finished
	
	interacted = false
	animation_tree.set("parameters/Idle/blend_position", initial_blend_position)
