extends ItemBase
class_name RangedWeapon

###This script is the base class for all ranged weapons

#####INSTRUCTIONS FOR IMPLEMENTING A RANGED WEAPON:

#add sprite and check rotation works correctly
#move ProjectileSpawn node to correct position
#add a right click ability as a child of the base node if needed and configure it
#configure other weapon stats such as projectile path and shoot pattern and chargable
#if using a custom shoot pattern, in the script of the weapon code that in the shoot_custom function
#add animations, use the example ranged weapon if needed
#test
#implement into loot tables


###################################### NOTE: ######################################
# this is just the base class for a ranged weapon, if you want custom code for your
# weapon, detach the script, attach a new one, and have it extend RangedWeapon
# DO NOT edit the code in the class unless you know what you are doing and have
# consulted kellen as it could easily brick all of the ranged weapons







#####SAME CODE AS MELEE CLASS

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













#####ONLY RANGED CODE
@onready var projectile_spawn: Node2D = $Node2D/ItemSprite/ProjectileSpawn#where the projectile spawns

@export var arrow_scene = preload("res://items/weapon_bases/projectile_base.tscn")#change what projectile to shoots

@export_enum("straight", "triple spread", "variation spread", "custom") var shoot_type#select from pre-built shooting patterns
@export var random_spread_if_random = 0#random spread it using "variation spread" pattern



# base func to shoot a projectile
func straight_shot(offset: int):
	var arrow: Area2D = arrow_scene.instance()
	get_tree().current_scene.add_child(arrow)
	arrow.launch(projectile_spawn.global_position, Vector2.LEFT.rotated(deg_to_rad(rotation_degrees + offset)), 400)

# shoots 3
func triple_shot_spread() -> void:
	straight_shot(0)
	straight_shot(12)
	straight_shot(-12)

# shoots a randomly offset arrow
func random_spread_shot():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = rng.randf_range(-random_spread_if_random, random_spread_if_random)
	straight_shot(random)

#BASE OF FUNCTION: copy and paste into ranged weapon code and write in the shooting pattern, be sure to select the shoot type as "custom"
func shoot_custom():
	pass

# called during the shoot animation to shoot with the correct type
func shoot():
	if shoot_type == "straight": straight_shot(0)
	elif shoot_type == "triple spread": triple_shot_spread()
	elif shoot_type == "variation spread": random_spread_shot()
	elif shoot_type == "custom": shoot_custom()


