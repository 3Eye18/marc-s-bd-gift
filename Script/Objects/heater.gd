extends StaticBody2D

@export var speech_sound = preload("res://Asset/Sounds/Texts.wav")
@onready var interaction_area = $"Interaction Area"
@onready var animation_tree = $AnimationTree

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


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogueManager.start_dialogue(DialogueManager.bottom_text, lines, speech_sound)
	await DialogueManager.dialogue_finished
