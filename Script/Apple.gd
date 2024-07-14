extends CharacterBody2D

enum State {
	Idle,
	Walk,
	Hurt,
}

signal Begone

@export var currentState = State.Idle

var Caught_Player_Sight
var can_see : bool
var chaser = null
var hit_sight :bool

@export var health = 5
@export var take_damage = false
@export var speed = 100

@onready var Animated_player = $AnimationPlayer
@onready var Sprite2d = $Sprite2D
@onready var RayCast = $RayCast2D
@onready var Navigation_Agent : NavigationAgent2D = $NavigationAgent2D


func _ready():
	#Navigation_Agent.target_position
	take_damage = false

func _physics_process(delta):
	
	#Navigation handler, grab the direction ONLY
	var dir = Vector2()
	dir = Navigation_Agent.get_next_path_position() - global_position
	dir = dir.normalized()
	
	
	State_Handler()
	
	#Change State to different correspond
	match currentState:
		#Change state to Idle, Where they stay and do nothing
		State.Idle:
			position = position.lerp(position, 0.01 * delta)
			Animated_player.play("Idle")
		#Change State where they walk to the Player
		State.Walk:
			Navigation_Agent.target_position = chaser.global_position
			velocity = dir * speed
			Animated_player.play("Walk")
			Line_in_Sight()
			move_and_slide()
			movement_flip()
		#Change State where they take damage, get stun until they can move
		State.Hurt:
			Animated_player.play("Hurt")
			position = position
			@warning_ignore("redundant_await")
			await Animated_player
		_:
			print_debug("There are not State to change")


#Check and See if the condition work, then change state to the following Condition
func State_Handler():
	if !take_damage:
		if can_see or hit_sight:
			currentState = State.Walk
		elif !can_see or !hit_sight:
			currentState = State.Idle
	elif take_damage:
		currentState = State.Hurt
	else:
		print_debug("No Condition to find to fix")
	return


#Flip Sprite on the direction they move
func movement_flip():
	if (chaser.position.x - position.x) > 0:
		Sprite2d.flip_h = true
	if (chaser.position.x - position.x) < 0:
		Sprite2d.flip_h = false


#when they get detected to see player, they get the node from player, and chase them when they see
func _on_detection_body_entered(body):
	if body.name == "Player":
		chaser = body
		can_see = true

# when the Player left the detection area, they lose the node, and change to Idle
@warning_ignore("unused_parameter")
func _on_detection_body_exited(body):
	chaser = null
	can_see = false

func Get_Shoot():
	health -= 1
	take_damage = true

	if health == 0:
		Begone.emit()
		queue_free()

func Line_in_Sight():
	RayCast.target_position = to_local(chaser.global_position)
	#var hit = RayCast.get_collider()
	#if hit != null and hit == "Player":
		#hit_sight = true
	#else:
		#hit_sight = false
