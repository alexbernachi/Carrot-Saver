extends Control

@onready var Health_label = $Amount

var Total_Health

func _ready():
	GameHandler.Update_Health.connect(Player_Health_Update)


func Player_Health_Update(Max_health, Current_health):
	
	Health_label.text = str(Current_health) + str("/") + str (Max_health)
