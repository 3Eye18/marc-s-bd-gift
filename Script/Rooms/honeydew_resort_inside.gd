extends Node2D

@onready var everyone_sfx = preload("res://Asset/Sounds/Talk Everyone.wav")
@onready var switch_sfx = preload("res://Asset/Sounds/Switch.wav")
@onready var starlo_finger_gun_sfx = preload("res://Asset/Sounds/Starlo Fingergun.wav")
@onready var clover_finger_gun_sfx = preload("res://Asset/Sounds/Clover Fingergun.wav")
@onready var timer = $Timer
@onready var ceroba = $NPCs/Ceroba
@onready var starlo = $NPCs/Starlo
@onready var martlet = $NPCs/Martlet
@onready var dalv = $NPCs/Dalv
@onready var ace = $NPCs/Ace
@onready var ed = $NPCs/Ed
@onready var mooch = $NPCs/Mooch
@onready var clover = $Clover
@onready var house = $House
@onready var npc = $NPCs
@onready var sfx = $SFX
@onready var bgm = $BGM


# Called when the node enters the scene tree for the first time.
func _ready():
	$House/Furnitures/Heater.interacted_heater.connect(_on_heater_interacted)
	play_cutscene()
	clover.hardcoded_can_move = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_heater_interacted():
	martlet.heater_interacted = true


func play_cutscene():
	house.visible = false
	npc.visible = false
	timer.start(2)
	await timer.timeout
	
	#Dark room
	DialogueManager.start_dialogue(
		DialogueManager.top_text,
		[
			{"line": "Here they come!", "sprite_name": "none"},
			{"line": "One...", "sprite_name": "none"},
			{"line": "Two...", "sprite_name": "none"},
			{"line": "Three!", "sprite_name": "none"}
		],
		martlet.speech_sound
	)
	await DialogueManager.dialogue_finished
	
	#Light on
	sfx.stream = switch_sfx
	sfx.play()
	bgm.play()
	house.visible = true
	npc.visible = true
	
	#Everyone sequence
	martlet.interacted = true
	ceroba.interacted = true
	starlo.interacted = true
	ed.interacted = true
	mooch.interacted = true
	ace.interacted = true
	dalv.interacted = true
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[	
			{"line": "Surprise!", "sprite_name": "none"},
			{"line": "Happy Birthday, Clover!", "sprite_name": "none"},
		],
		everyone_sfx
	)
	await DialogueManager.dialogue_finished
	martlet.interacted = false
	ceroba.interacted = false
	starlo.interacted = false
	ed.interacted = false
	mooch.interacted = false
	ace.interacted = false
	dalv.interacted = false

	#Ceroba
	ceroba.interacted = true
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "Isn't this great, Clover?", "sprite_name": "ceroba_smile_1"},
			{"line": "This party is Martlet's idea.", "sprite_name": "ceroba_smile_1"},
		],
		ceroba.speech_sound
	)
	await DialogueManager.dialogue_finished
	ceroba.interacted = false
	
	#Martlet
	martlet.interacted = true
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "We don't know how a human's party looks like.", "sprite_name": "martlet_sweat_1"},
			{"line": "So, I'm sorry if isn't what you expected.", "sprite_name": "martlet_sweat_1"},
		],
		martlet.speech_sound
	)
	await DialogueManager.dialogue_finished
	martlet.interacted = false
	
	#Starlo
	starlo.interacted = true
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "Don't worry too much, Feathers.", "sprite_name": "starlo_smile_2"},
			{"line": "I'm sure our deputy will love it.", "sprite_name": "starlo_smile_2"},
			{"line": "Plus, we even got to meet Clover's other friends.", "sprite_name": "starlo_smile_2"},
		],
		starlo.speech_sound
	)
	await DialogueManager.dialogue_finished
	starlo.interacted = false
	
	#Dalv
	dalv.interacted = true
	clover.animation_tree.set("parameters/Idle/blend_position", Vector2(-1, 0))
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "Hello, Clover.", "sprite_name": "dalv_smile_2"},
			{"line": "I see you made a lot of friends.", "sprite_name": "dalv_smile_2"},
			{"line": "Thanks to you, I get to meet these amazing monsters.", "sprite_name": "dalv_smile_2"},
			{"line": "Sheriff North Star and his posse did a lot of prep work.", "sprite_name": "dalv_smile_2"},
		],
		dalv.speech_sound
	)
	await DialogueManager.dialogue_finished
	clover.animation_tree.set("parameters/Idle/blend_position", Vector2(0, -1))
	dalv.interacted = false
	
	#Edward
	ed.interacted = true
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "Don't mention it, buddy.", "sprite_name": "ed_happy"},
		],
		ed.speech_sound
	)
	await DialogueManager.dialogue_finished
	ed.interacted = false
	
	#Mooch
	mooch.interacted = true
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "Anything for our deputy.", "sprite_name": "mooch_smile"},
		],
		mooch.speech_sound
	)
	await DialogueManager.dialogue_finished
	mooch.interacted = false
	
	#Finger Gun sequence
	starlo.interacted = true
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "Can I have a Yeehaw?", "sprite_name": "starlo_happy"},
		],
		starlo.speech_sound
	)
	await DialogueManager.dialogue_finished
	starlo.interacted = false
	
	starlo.finger_gun = true
	timer.start(0.4)
	await timer.timeout
	sfx.stream = starlo_finger_gun_sfx
	sfx.play()
	await starlo.animation_tree.animation_finished
	
	clover.finger_gun = true
	timer.start(0.4)
	await timer.timeout
	sfx.stream = clover_finger_gun_sfx
	sfx.play()
	await clover.animation_tree.animation_finished
	
	
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "They grow up so fast.", "sprite_name": "starlo_happy"},
		],
		starlo.speech_sound
	)
	await DialogueManager.dialogue_finished
	starlo.finger_gun = false
	clover.finger_gun = false
	
	#Ceroba
	ceroba.interacted = true
	DialogueManager.start_dialogue(
		DialogueManager.bottom_text,
		[
			{"line": "Come on people, don't make Clover wait.", "sprite_name": "ceroba_smile_1"},
			{"line": "Let's start the party!", "sprite_name": "ceroba_happy"},
		],
		ceroba.speech_sound
	)
	await DialogueManager.dialogue_finished
	ceroba.interacted = false
	
