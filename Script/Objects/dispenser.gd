extends StaticBody2D

@export var speech_sound = preload("res://Asset/Sounds/Texts.wav")
@onready var interaction_area = $"Interaction Area"

var lines: Array[Dictionary] = [
	{
		"line": "A cooler full of honey, ready for drinking.",
		"sprite_name": "none"
	},
		{
		"line": "...Yum?",
		"sprite_name": "none"
	}
]


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogueManager.start_dialogue(DialogueManager.bottom_text, lines, speech_sound)
	await DialogueManager.dialogue_finished
