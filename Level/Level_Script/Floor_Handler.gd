extends Node2D

@onready var UI = $CanvasLayer
@onready var Enemy_Holder = $Enemy_holder
@onready var Map_Handler = $Map_Handler
@onready var Animation_Player = $Map_Handler/AnimationPlayer

var Total_of_enemy = 0
var Battle_End = false

#Reset the Map to a new Visible
func _exit_tree():
	Battle_End = false

#Turn on Game UI
func _ready():
	UI.visible = true


@warning_ignore("unused_parameter")
func _process(delta):
	#Grab and Count total of enemy in the node
	Total_of_enemy = Enemy_Holder.get_child_count()
	
	#check to see if the enemy is gone and the battle end
	if Total_of_enemy == 0 and Battle_End == false:
		print("level_Compete")
		
		Animation_Player.play("Battle_End")
		
		Battle_End = true



@warning_ignore("unused_parameter")
func _on_entrance_door_body_entered(body):
	
	Animation_Player.play("Battle_Begin")
	pass # Replace with function body.
