extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_handling()


func sprite_handling():
	var player_collision_box = $Clover/CollisionShape2D
	var player_bottom = player_collision_box.global_position.y + player_collision_box.shape.size.y / 2
	
	var child_count = $House/Furnitures.get_child_count()
	for i in child_count:
		var child = $House/Furnitures.get_child(i)
		if is_instance_of(child, StaticBody2D):
			var child_collision_box = child.get_node("CollisionShape2D")
			var child_top = child_collision_box.global_position.y - child_collision_box.shape.size.y * 4 /2
			
			if player_bottom < child_top:
				child.z_index = 1
			else:
				child.z_index = 0
