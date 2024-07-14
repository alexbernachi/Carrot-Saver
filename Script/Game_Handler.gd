extends Node

signal Update_Health
signal Update_Player_Death

var Player_Current_Health = 0
var Player_Max_Health = 4
var Player_Death := false


var current_scene 

func _ready():
	Player_Current_Health = Player_Max_Health



@warning_ignore("unused_parameter")
func _process(delta):
	
	#reset the Scene when the Player Died
	if Player_Death == true:
		get_tree().reload_current_scene()
		Player_Current_Health = Player_Max_Health
		Player_Death = false

func Take_Damage():
	Player_Current_Health -= 1
	
	Update_Health.emit(Player_Max_Health ,Player_Current_Health)
	if Player_Current_Health == 0:
		Player_Current_Health = 0
		Update_Player_Death.emit()
		
		#get_tree().reload_current_scene()
		#Player_Current_Health = Player_Max_Health

	
	


