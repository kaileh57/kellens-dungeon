class_name HurtBox
extends Area2D

###This script manages hurtboxes
# hurtboxes accept incomming damage and apply it to the owner



#connects being hit to the damage function
func _ready() -> void:
	self.area_entered.connect(_take_damage)

#applies damage if what it hit can take damage
func _take_damage(hitbox: HitBox) -> void:
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage, hitbox.knockback, hitbox.knockback_direction, hitbox.do_stun_animation)#add any other attack possibilities to this function
	if hitbox.is_projectile:
		hitbox.queue_free()
