extends HitBox
class_name Projectile

###This script is the base class for all projectiles

#####INSTRUCTIONS FOR IMPLEMENTING A PROJECTILE:

#add sprite and check rotation works correctly
#configure all stats such as damage, effects, and anything else
#add animations if needed
#test
#implement intothe weapon or enemy that shoots it


###################################### NOTE: ######################################
# this is just the base class for a projectile, if you want custom code for your
# weapon, detach the script, attach a new one, and have it extend Projectile
# DO NOT edit the code in the class unless you know what you are doing and have
# consulted kellen as it could easily brick all of the projectiles










var direction: Vector2 = Vector2.ZERO
var knife_speed: int = 0
var is_projectile = true

func launch(initial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_position
	direction = dir
	knockback_direction = dir
	knife_speed = speed
	
	rotation += dir.angle() + PI/4
	
	
func _physics_process(delta: float) -> void:
	position += direction * knife_speed * delta
