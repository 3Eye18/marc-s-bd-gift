extends MarginContainer

signal finished_displaying

@onready var margin_container = $MarginContainer
@onready var timer = $LetterDisplayTimer
@onready var label = $MarginContainer/HBoxContainer/Label
@onready var audio_player = $AudioStreamPlayer
@onready var animated_sprite = $AnimatedSprite2D

@export var LETTER_TIME = 0.03
@export var SPACE_TIME = 0.06
@export var PUNCTUATION_TIME = 0.12

var text = ""
var sprite = "none"
var letter_index = 0


func display_text(text_to_display: String, speech_sfx: AudioStream, sprite_name: String):
	text = text_to_display
	sprite = sprite_name
	
	if sprite == "none":
		margin_container.add_theme_constant_override("margin_left", 30)
	else:
		margin_container.add_theme_constant_override("margin_left", 270)
	
	label.text = ""
	audio_player.stream = speech_sfx
	
	_display_letter()


func _display_letter():
	if letter_index < text.length():
		label.text += text[letter_index]
		
		letter_index += 1
		if letter_index >= text.length():
			animated_sprite.stop()
			finished_displaying.emit()
			return
		
		match text[letter_index]:
			"!", ".", ",", "?", ":":
				timer.start(PUNCTUATION_TIME)
			" ":
				timer.start(SPACE_TIME)
			_:
				timer.start(LETTER_TIME)
				animated_sprite.play(sprite)
				audio_player.play()


func _skip_text():
	timer.stop()
	label.text = text


func _on_letter_display_timer_timeout():
	_display_letter()
