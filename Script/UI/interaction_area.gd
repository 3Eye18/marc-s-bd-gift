extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"
var direction


var interact: Callable = func():
	pass


func _on_body_entered(body):
	if body.is_in_group("player"):
		InteractionManager.register_area(self)
		
		var distance_to_player_x = absf(self.global_position.x - body.global_position.x)
		var distance_to_player_y = absf(self.global_position.y - body.global_position.y)
		
		if distance_to_player_x >= distance_to_player_y:
			if self.global_position.x >= body.global_position.x:
				direction = "left"
			else:
				direction = "right"
		else:
			if self.global_position.y >= body.global_position.y:
				direction = "down"
			else:
				direction = "up"


func _on_body_exited(body):
	if body.is_in_group("player"):
		InteractionManager.unregister_area(self)
