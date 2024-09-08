extends StaticBody2D

@export var speech_sound = preload("res://Asset/Sounds/Texts.wav")
@onready var interaction_area = $"Interaction Area"
@onready var animation_tree = $AnimationTree

var martlet = preload("res://Scene/Characters/martlet.tscn")

var lines: Array[Dictionary] = [
	{
		"line": "Nice and cozy!",
		"sprite_name": "none"
	},
		{
		"line": "You notice a sticker on the heater.",
		"sprite_name": "none"
	},
	{
		"line": "\"Crafted with love by Chujin & Martlet!\"",
		"sprite_name": "none"
	}
]

var martlet_line: Array[Dictionary] = [
	{
		"line": "Oh, Chujin and I made this heater...",
		"sprite_name": "martlet_sad_2"
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
		"line": "But I'm sure you can change his mind",
		"sprite_name": "martlet_sad_1"
	}
]


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogueManager.start_dialogue(DialogueManager.bottom_text, lines, speech_sound)
	await DialogueManager.dialogue_finished
	DialogueManager.start_dialogue(DialogueManager.bottom_text, martlet_line, martlet.speech_sound)
	await DialogueManager.dialogue_finished
