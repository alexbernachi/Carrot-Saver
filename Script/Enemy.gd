extends CharacterBody2D


enum State {
	Idle,
	Walk,
	Hurt,
}

signal Begone

@export var currentState = State.Idle

var can_see : bool
var chaser = null
@export var health = 5

@export var take_damage = false
@export var speed = 1
@export var FruitType_ID : String

@onready var Animated_player = $AnimationPlayer
@onready var Sprite2d = $Sprite2D

func _ready():
	take_damage = false

func _physics_process(delta):
	match currentState:
		State.Idle:
			position = position.lerp(position, 0.01 * delta)
			Animated_player.play("Idle")
			
		State.Walk:
			position = position.lerp(chaser.position, speed * delta)
			Animated_player.play("Walk")
			movement_flip()
		State.Hurt:
			Animated_player.play("Hurt")
			position = position
			@warning_ignore("redundant_await")
			await Animated_player
		_:
			print_debug("There are not State to change")
			currentState = State.Idle
	
	if take_damage == false:
		if can_see:
			currentState = State.Walk
		if !can_see:
			currentState = State.Idle


func movement_flip():
	if (chaser.position.x - position.x) > 0:
		Sprite2d.flip_h = true
	if (chaser.position.x - position.x) < 0:
		Sprite2d.flip_h = false



func _on_detection_body_entered(body):
	if body.name == "Player":
		chaser = body
		currentState = State.Walk
		can_see = true

@warning_ignore("unused_parameter")
func _on_detection_body_exited(body):
	chaser = null
	can_see = false
	currentState = State.Idle

func Get_Shoot():
	health -= 1
	take_damage = true
	currentState = State.Hurt

	if health == 0:
		Begone.emit()
		queue_free()

