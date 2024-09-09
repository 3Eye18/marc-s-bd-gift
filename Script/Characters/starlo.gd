extends CharacterBody2D

@export var speech_sound = preload("res://Asset/Sounds/Texts.wav")
@export var first_blend_position = Vector2(0, 1)
@export var SPEED: float = 300

@onready var interaction_area = $"Interaction Area"
@onready var animation_tree = $AnimationTree
@onready var timer = $Timer

var interacted: bool = false
var finger_gun: bool = false
var direction = Vector2.ZERO
var interact_count: int = 0

var lines_0: Array[Dictionary] = [
	{
		"line": "Howdy, Clover. I gotta say...",
		"sprite_name": "starlo_smile_2"
	},
	{
		"line": "Thank ye for movin' in with Ceroba.",
		"sprite_name": "starlo_normal_2"
	},
	{
		"line": "Havin' to live in the big house alone...",
		"sprite_name": "starlo_pensive"
	},
	{
		"line": "It must be tough for her.",
		"sprite_name": "starlo_pensive"
	},
	{
		"line": "But I bet yer company will make things better.",
		"sprite_name": "starlo_smile_2"
	},
]

var lines_1: Array[Dictionary] = [
	{
		"line": "Say...Clover.",
		"sprite_name": "starlo_normal_2"
	},
	{
		"line": "Do ye find the Dunes too hot for yer likin'?",
		"sprite_name": "starlo_normal_3"
	},
	{
		"line": "Wait, who am I kiddin'? Ye're fireproof.",
		"sprite_name": "starlo_happy"
	},
	{
		"line": "...wait...",
		"sprite_name": "starlo_oh_2"
	},
	{
		"line": "...Ye're not?",
		"sprite_name": "starlo_oh_1"
	},
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	animation_tree.set("parameters/Idle/blend_position", first_blend_position)


func _physics_process(delta):
	velocity = direction * SPEED
	
	if interacted and finger_gun:
		animation_tree.get("parameters/playback").travel("finger_gun")


func _on_interact():
	var initial_blend_position = animation_tree.get("parameters/Idle/blend_position")
	interacted = true
	
	match interact_count:
		0:
			DialogueManager.start_dialogue(DialogueManager.bottom_text, lines_0, speech_sound)
			interact_count += 1
		_:
			DialogueManager.start_dialogue(DialogueManager.bottom_text, lines_1, speech_sound)
	await DialogueManager.dialogue_finished
	
	interacted = false
	animation_tree.set("parameters/Idle/blend_position", initial_blend_position)


func move(direction_string: String, distance: float):
	match direction_string:
		"right":
			direction.x = 1
		"left":
			direction.x = -1
		"up":
			direction.y = -1
		"down":
			direction.y = 1
	timer.start(distance / SPEED)


func _on_timer_timeout():
	direction = Vector2.ZERO
