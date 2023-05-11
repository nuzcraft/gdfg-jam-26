extends CharacterBody2D

@export var initial_speed: int
@export var final_speed: int
var speed: int

func _ready():
	speed = initial_speed

func _physics_process(delta):
	velocity = Vector2.UP.rotated(rotation) * speed
	move_and_slide()

func blow_up():
	queue_free()
	
func speed_up():
	speed = final_speed	
