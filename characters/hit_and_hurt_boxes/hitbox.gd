class_name HitBox
extends Area2D

###This script manages hitboxes
# hitboxes deal damage to apropriate hurtboxes


#define hitbox damage
@export var damage : int = 10
@export var knockback :int = 200
var knockback_direction: Vector2 = Vector2.ZERO
@export var do_stun_animation: bool = true
#add any other properties

