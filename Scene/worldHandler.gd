extends Node2D

@onready var Enter_room = $LeftRoom
@onready var Battle_room = $MiddleRoom
@onready var Exit_room = $RightRoom

@onready var Enter_door = $EnterDoor
@onready var Exit_door = $ExitDoor
@onready var Door_collision = $DoorClose/CollisionShape2D
@onready var Animated_Door = $AnimationPlayer

#func _ready():
	#Enter_room.visible = false
	#Battle_room.visible = true
	#Exit_room.visible = true


#func _on_enter_door_body_entered(body):
	#if body.name == "Player":
		#Animated_Door.play("Enter_Room")
		#print("it a player")


func _on_exit_door_body_exited(body):
	if body.name == "Player":
		Animated_Door.play("Exit_Room")
	pass # Replace with function body.
