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
	},
	{
		"line": "Though, you can't see people on the surface now",
		"sprite_name": "martlet_sad_2"
	},
	{
		"line": "when it is your birthday.",
		"sprite_name": "martlet_sad_3"
	},
	{
		"line": "I'm sorry that thing must be like this,",
		"sprite_name": "martlet_sad_2"
	},
	{
		"line": "but at least you're safe and well.",
		"sprite_name": "martlet_sad_1"
	},
]

var lines_1: Array[Dictionary] = [
	{
		"line": "By the way, Clover,",
		"sprite_name": "martlet_normal_2"
	},
	{
		"line": "how does it feel to live in such a big mansion?",
		"sprite_name": "martlet_normal_1"
	},
	{
		"line": "I have always wanted a big house.",
		"sprite_name": "martlet_normal_1"
	},
	{
		"line": "But I'll admit, living alone is lonely sometimes.",
		"sprite_name": "martlet_normal_2"
	},
	{
		"line": "And it's probably worse if your house is big.",
		"sprite_name": "martlet_normal_3"
	},
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
		"line": "He was a great mentor and a good friend.",
		"sprite_name": "martlet_sad_1"
	},
	{
		"line": "He didn't have a friendly viewpoint toward humans...",
		"sprite_name": "martlet_sad_3"
	},
	{
		"line": "But I'm sure you can change his mind.",
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
