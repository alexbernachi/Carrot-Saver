extends Area2D

@export var Floor = 0
@export var Room = 0

func _on_body_entered(body):
	if body.name == "Player":
		var current_scene_file = get_tree().current_scene.scene_file_path
		@warning_ignore("unused_variable")
		var Next_level_number = current_scene_file.to_int()
		print(str(Room), "    ", str(Floor))
		
		var Next_level_path = "res://Level/floor_" + str(Floor) + "_room_" + str(Room) + ".tscn"
		
		get_tree().change_scene_to_file(Next_level_path)
		
		
