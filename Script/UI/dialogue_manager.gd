#Position cheatsheet:
	#top = Vector2.ZERO
	#bot = Vector2(0, 508)

extends Node

signal dialogue_finished

@onready var textbox_no_sprite_scene = preload("res://Scene/UI/textbox.tscn")

var textbox
var textbox_position: Vector2
var sfx: AudioStream
var sprite_name

var dialogue_lines: Array[Dictionary] = []
var current_line_index = 0
var is_dialogue_active = false
var can_advance_line = false


func start_dialogue(position: Vector2, lines: Array[Dictionary], speech_sfx: AudioStream):
	if is_dialogue_active:
		return
	
	dialogue_lines = lines
	textbox_position = position
	sfx = speech_sfx
	_show_text_box()
	
	is_dialogue_active = true


func _show_text_box():
	textbox = textbox_no_sprite_scene.instantiate()
	textbox.finished_displaying.connect(_on_textbox_finished_displaying)
	get_tree().root.get_child(2).get_child(0).add_child(textbox)
	textbox.global_position = textbox_position
	textbox.display_text(dialogue_lines[current_line_index].line, sfx, dialogue_lines[current_line_index].sprite_name)
	can_advance_line = false


func _on_textbox_finished_displaying():
	can_advance_line = true


func _unhandled_input(event):
	if (
		event.is_action_pressed("interact") and
		is_dialogue_active and
		can_advance_line
	):
		textbox.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			dialogue_finished.emit()
			return
		
		_show_text_box()
	
	if (
		event.is_action_pressed("skip") and
		is_dialogue_active and 
		!can_advance_line
	):	
		textbox._skip_text()
		can_advance_line = true
	
