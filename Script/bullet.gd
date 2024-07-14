extends Area2D

var Speed = 200

var Explosion_Effect = preload("res://Scene/carrot_explosion.tscn")

@onready var Animation_player = $AnimationPlayer

func _physics_process(delta):
	position += transform.x * Speed * delta



func _on_body_entered(body):
	
	Animation_player.play("End_Bullet")
	
	if body.has_method("Get_Shoot"):

		body.Get_Shoot()
		pass # Replace with function body.
