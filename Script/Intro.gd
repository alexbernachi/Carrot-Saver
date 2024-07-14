extends Control



func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Level/floor_1_room_1.tscn")
	pass # Replace with function body.


func _on_credit_pressed():
	get_tree().change_scene_to_file("res://Scene/credit.tscn")
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
