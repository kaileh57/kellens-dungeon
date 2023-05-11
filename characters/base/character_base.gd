extends CharacterBody2D
class_name CharacterBase

###This script manages all movable characters

#DO NOT MESS WITH THIS UNLESS YOU REALLY KNOW WHAT YOU'RE DOING, ASK KELLEN












const FRICTION: float = 0.15

#variables used for all character settings
@export var accerelation: int = 40
@export var max_speed: int = 100

#nodes to be referenced
@onready var animated_sprite: AnimatedSprite2D = get_node("CharacterSprite")

#moving variables
var move_direction: Vector2 = Vector2.ZERO

#runs every physics frame, moves character then applies friction
func _physics_process(_delta: float):
	move()
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	
#funtion to calculate and limit movement
func move():
	move_direction = move_direction.normalized()
	velocity += move_direction * accerelation
	velocity = velocity.limit_length(max_speed)



