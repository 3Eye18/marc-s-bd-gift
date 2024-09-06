extends Node

signal player_warped

# Called when the node enters the scene tree for the first time.
func _ready():
	$Clover.position = Vector2(760.01, -628.368)
	player_warped.connect(get_parent().get_parent()._on_player_warped.bind(self))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if (body == $Clover):
		player_warped.emit()
