extends CharacterBody2D

signal Dead_Update

@export var speed = 200
@export var friction = 0.01
@export var acceleration = 0.1
@export var bullet_Speed = 200

@onready var weapon : Sprite2D = $Weapon
@onready var Animated_Sprite = $AnimatedSprite2D
@onready var Animation_Player = $AnimationPlayer
@onready var Cooldown_Timer = $Shoot_Cooldown

@export var is_Alive:= true
var is_Dead:= false

const bulletPath = preload("res://Scene/bullet.tscn")

func _ready():
	GameHandler.Update_Player_Death.connect(Player_Death)
	is_Alive = true
	Animation_Player.play("RESET")
	is_Dead = false

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if is_Alive == false:

		return
	
	var direction = get_input_movement()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	if is_Dead == true:
		Animation_Player.play("Dead")
		pass
	
	#print(Cooldown_Timer.time_left)
	shooting_handling()
	move_and_slide()
	Animation_Handler(direction)

#Get the Input
func get_input_movement():
	var input = Vector2(
	Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	return input

func shooting_handling():
	weapon.look_at(get_global_mouse_position())
	if Input.is_action_pressed("Shoot") and Cooldown_Timer.is_stopped():
		shoot()

func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Weapon/BulletPoint.global_position
	bullet.global_rotation = $Weapon/BulletPoint.global_rotation
	bullet.Speed = bullet_Speed
	Cooldown_Timer.start()

func Animation_Handler(dir):
	if dir.length() > 0:
		Animated_Sprite.play("Walk")
		#if dir.x > 0:
			#Animated_Sprite.flip_h = false
		#if dir.x < 0:
			#Animated_Sprite.flip_h = true
	else:
		Animated_Sprite.play("Idle")
	
	
	var Mouse_Position = get_global_mouse_position()
	
	if Mouse_Position.x > position.x:
		Animated_Sprite.flip_h = false
	elif  Mouse_Position.x < position.x:
		Animated_Sprite.flip_h = true


func Dead():
	GameHandler.Player_Death = true


func _on_hurt_box_body_entered(body):
	if !is_Alive:
		return
	
	if body.is_in_group("Enemy"):
		GameHandler.Take_Damage()
		Animation_Player.play("Damage_invincibility")

func Player_Death():
	is_Dead = true

