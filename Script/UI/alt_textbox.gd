extends MarginContainer

signal finished_displaying

@onready var timer = $LetterDisplayTimer
@onready var label = $MarginContainer/HBoxContainer/Label
@onready var audio_player = $AudioStreamPlayer

@export var LETTER_TIME = 0.03
@export var SPACE_TIME = 0.06
@export var PUNCTUATION_TIME = 0.12

var text = ""
var letter_index = 0


func display_text(text_to_display: String, speech_sfx: AudioStream):
	text = text_to_display
	label.text = ""
	audio_player.stream = speech_sfx
	
	_display_letter()


func _display_letter():
	if letter_index < text.length():
		label.text += text[letter_index]
		
		letter_index += 1
		if letter_index >= text.length():
			finished_displaying.emit()
			return
		
		match text[letter_index]:
			"!", ".", ",", "?", ":":
				timer.start(PUNCTUATION_TIME)
			" ":
				timer.start(SPACE_TIME)
			_:
				timer.start(LETTER_TIME)
				audio_player.play()


func _skip_text():
	timer.stop()
	label.text = text


func _on_letter_display_timer_timeout():
	_display_letter()
