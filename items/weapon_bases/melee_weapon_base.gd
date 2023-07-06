extends ItemBase
class_name MeleeWeapon

###This script is the base class for all melee weapons

#####INSTRUCTIONS FOR IMPLEMENTING A MELEE WEAPON:

#add sprite and check rotation works correctly
#add a right click ability as a child of the base node if needed and configure it
#configure other weapon stats such as damage, effects, and chargable
#add animations, use the example melee weapon if needed
#test
#implement into loot tables


###################################### NOTE: ######################################
# this is just the base class for a melee weapon, if you want custom code for your
# weapon, detach the script, attach a new one, and have it extend PlayerBase
# DO NOT edit the code in the class unless you know what you are doing and have
# consulted kellen as it could easily brick all of the players










@export var rotation_offset: int = 0

# animation player exists in itembase class
# player detector exists in itembase class
@onready var hitbox: Area2D = $Node2D/ItemSprite/HitBox
@onready var charge_particles: GPUParticles2D = $Node2D/ItemSprite/ChargeParticles

var is_projectile = false

@export var chargable: bool = false

@onready var has_item_ability: bool = false# TODO: replace with path to ability class.exists
@onready var item_ability = $Node2D# TODO: replace with path to ability class
var can_active_ability: bool = true

#called every tick on this weapon
func get_input():
	if Input.is_action_just_pressed("attack_main") and not animation_player.is_playing() and chargable:#charge the weapon if it's possible
		animation_player.play("charge")
	elif Input.is_action_just_released("attack_main"):
		if animation_player.is_playing() and animation_player.current_animation == "charge":#cancel the charge
			animation_player.play("attack")
		elif charge_particles.emitting:
			animation_player.play("strong_attack")#do the charge attack
	elif Input.is_action_just_pressed("attack_alt") and has_item_ability and not is_busy() and can_active_ability:#call the active ability if possible
		item_ability.ability()



#checks if the weapon is busy
func is_busy() -> bool:
	if animation_player.is_playing() or charge_particles.emitting:
		return true
	return false


