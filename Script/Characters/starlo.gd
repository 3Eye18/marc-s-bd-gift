extends CharacterBody2D

@export var speech_sound = preload("res://Asset/Sounds/Texts.wav")
@export var first_blend_position = Vector2(0, 1)
@export var SPEED: float = 300

@onready var interaction_area = $"Interaction Area"
@onready var animation_tree = $AnimationTree
@onready var timer = $Timer

var lines: Array[Dictionary] = [
	{
		"line": "egassem drawkcaB",
		"sprite_name": "starlo_happy"
	}
]
var interacted: bool = false
var direction = Vector2.ZERO

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	animation_tree.set("parameters/Idle/blend_position", first_blend_position)


func _physics_process(delta):
	velocity = direction * SPEED


func _on_interact():
	move("down", 50)
	#var initial_blend_position = animation_tree.get("parameters/Idle/blend_position")
	#interacted = true
	#
	#DialogueManager.start_dialogue(DialogueManager.bottom_text, lines, speech_sound)
	#await DialogueManager.dialogue_finished
	#
	#interacted = false
	#animation_tree.set("parameters/Idle/blend_position", initial_blend_position)


func move(direction_string: String, distance: float):
	var target_position: Vector2
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
