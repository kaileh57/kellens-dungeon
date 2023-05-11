extends Node2D
class_name ItemBase

###This script is the base class for all items

#####INSTRUCTIONS FOR IMPLEMENTING A NEW ITEM:

#add sprite and check rotation works correctly
#add a right click ability as a child of the base node if needed and configure it
#configure other stats such as damage, effects, and chargable or whatever this thing does
#add animations, use the example weapons if needed
#test
#implement into loot tables


###################################### NOTE: ######################################
# this is just the base class for a item, if you want custom code for your
# item, detach the script, attach a new one, and have it extend ItemBase
# DO NOT edit the code in the class unless you know what you are doing and have
# consulted kellen as it could easily brick all of the items in the game










@export var on_floor: bool = false

@onready var animation_player: AnimationPlayer = get_node("Node2D/SpriteAnimator")
@onready var player_detector: Area2D = get_node("Node2D/PlayerDetector")


#disables the items collision if it's on the player at spawn
func _ready():
	if not on_floor:
		player_detector.set_collision_mask_value(4, false)


#rotates and flips the item to what it should be
func move(mouse_direction: Vector2):
	if not animation_player.is_playing() or animation_player.current_animation == "charge":
		rotation = mouse_direction.angle()
		#hitbox.knockback_direction = mouse_direction
		if scale.y == 1 and mouse_direction.x < 0:
			scale.y = -1
		elif scale.y == -1 and mouse_direction.x > 0:
			scale.y = 1

#these 2 tween functions are used to slide the item from the player to the ground
func interpolate_pos(initial_pos: Vector2, final_pos: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "position", final_pos, 0.8).from(initial_pos).set_trans(tween.TRANS_QUART).set_ease(tween.EASE_OUT)
	player_detector.set_collision_mask_value(4, true)


##### mostly unused utility functions

#called when the item is scrolled to
func switch_to():
	show()

#called when the item is scrolled away from
func switch_from():
	hide()


#called every tick on this item
func get_input():
	pass

func is_busy() -> bool:
	if animation_player.is_playing():
		return true
	return false

#this code detects when it's touching a player and makes the player pick it up, then disables being picked up
func _on_player_detector_area_entered(area):
	print("e")
	if area != null && area.get_parent().max_items > area.get_parent().items.get_child_count():
		player_detector.set_collision_mask_value(4, false)
		area.get_parent().pick_up_item(self)
		
		position = Vector2(0,0)
