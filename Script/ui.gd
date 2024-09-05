extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $"TextboxContainer/MarginContainer/HBoxContainer/Start Symbol"
@onready var text = $TextboxContainer/MarginContainer/HBoxContainer/Text
@onready var new_tween = get_tree().create_tween()

@export var TEXT_SPEED = 40.0
@export var MIN_TWEEN_DURATION = 0.5

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var do_once = false
var text_queue = []


# Called when the node enters the scene tree for the first time.
func _ready():
	print("State: READY")
	hide_textbox()
	queue("a")
	queue("aaaaaaaaa")
	queue("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
	queue("Like my little existential crisis?")

func _process(delta):
	if !new_tween.is_running() and do_once:
		change_state(State.FINISHED)
	
	match current_state:
		State.READY:
			do_once = true
			if !text_queue.is_empty():
				new_tween = display_text()
		State.READING:
			if Input.is_action_just_pressed("skip"):
				text.visible_ratio = 1
				new_tween.stop()
		State.FINISHED:
			do_once = false
			if Input.is_action_just_pressed("interact"):
				change_state(State.READY)
				if !text_queue.size():
					hide_textbox()


func queue(next_text):
	text_queue.push_back(next_text)


func hide_textbox():
	start_symbol.text = ""
	text.text = ""
	textbox_container.hide()


func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()


func display_text():
	text.text = ""
	var next_text = text_queue.pop_front()
	text.text = next_text
	change_state(State.READING)
	text.visible_ratio = 0.0
	show_textbox()
	
	var new_tween = get_tree().create_tween()
	if MIN_TWEEN_DURATION > next_text.length() / TEXT_SPEED: 
		new_tween.tween_property(text, "visible_ratio", 1.0, MIN_TWEEN_DURATION)
	else:
		new_tween.tween_property(text, "visible_ratio", 1.0, next_text.length() / TEXT_SPEED)
	return new_tween

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("State: READY")
		State.READING:
			print("State: READING")
		State.FINISHED:
			print("State: FINISHED")
