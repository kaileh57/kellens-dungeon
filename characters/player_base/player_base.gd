extends CharacterBase
class_name PlayerBase

###This script is the base class for all player characters

#####INSTRUCTIONS FOR IMPLEMENTING A PLAYER CHARACTER:

#add sprite and check rotation works correctly
#add default weapons or items
#configure other stats such as health, effects, and abilities
#add animations, use the player base or red
#test
#implement character selector


###################################### NOTE: ######################################
# this is just the base class for a player, if you want custom code for your
# weapon, detach the script, attach a new one, and have it extend MeleeWeapon
# DO NOT edit the code in the class unless you know what you are doing and have
# consulted kellen as it could easily brick all of the melee weapons










var current_item: Node2D

 

enum {UP, DOWN}




@onready var items: Node2D = get_node("Items")
@onready var fsm: FSM = $FSM #($ is a shorthand for get node)
@onready var animation_player: AnimationPlayer = get_node("SpriteAnimator")


#Export Variables:
@export var max_items: int = 6
@export var damagable: bool = true
@export var health: float = 2
@export var max_health: float = 2

#sets the current item to the first one the player has(if they have one)
func _ready():
	if items.get_child_count() != 0:
		current_item = items.get_child(0)
	state_logic()

#checks if the player should be flipped and rotates the current item based on mouse position
func _process(_delta):
	var mouse_direction: Vector2
	mouse_direction = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	if items.get_child_count() != 0:
		current_item.move(mouse_direction)
	get_input()

#checks for inputs
func get_input():
	#movement inputs
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("down"):
		move_direction += Vector2.DOWN
	if Input.is_action_pressed("left"):
		move_direction += Vector2.LEFT
	if Input.is_action_pressed("right"):
		move_direction += Vector2.RIGHT
	if Input.is_action_pressed("up"):
		move_direction += Vector2.UP
	#item scrolling/dropping inputs
	var item_count = items.get_child_count()
	if item_count != 0:
		if not current_item.is_busy():
			if Input.is_action_just_released("scroll_up"):
				_switch_item(-1)#-1 is up
			elif Input.is_action_just_released("scroll_down"):
				_switch_item(-2)#-2 is down
			elif Input.is_action_just_pressed("drop"):# and current_item.get_index() != 0:
				_drop_item()
			elif Input.is_action_just_pressed("1") && item_count >= 1: _switch_item(1)
			elif Input.is_action_just_pressed("2") && item_count >= 2: _switch_item(2)
			elif Input.is_action_just_pressed("3") && item_count >= 3: _switch_item(3)
			elif Input.is_action_just_pressed("4") && item_count >= 4: _switch_item(4)
			elif Input.is_action_just_pressed("5") && item_count >= 5: _switch_item(5)
			elif Input.is_action_just_pressed("6") && item_count >= 6: _switch_item(6)
			elif Input.is_action_just_pressed("7") && item_count >= 7: _switch_item(7)
			elif Input.is_action_just_pressed("8") && item_count >= 8: _switch_item(8)
			elif Input.is_action_just_pressed("9") && item_count >= 9: _switch_item(9)
		#unused
		current_item.get_input()
	state_logic()

#code that transfers an item from the ground to the player
func pick_up_item(item: Node2D):
	item.get_parent().call_deferred("remove_child", item)
	items.call_deferred("add_child", item)
	item.set_deferred("owner", items)
	current_item.switch_from()
	current_item = item
	current_item.switch_to()

#transfers the item in the players hand to the floor and gives it a starting velocity
func _drop_item():
	var item_to_drop: Node2D = current_item
	_switch_item(-1)
	items.call_deferred("remove_child", item_to_drop)
	get_parent().call_deferred("add_child", item_to_drop)
	item_to_drop.set_owner(get_parent())
	#await(item_to_drop.tree_entered)
	item_to_drop.show()
	
	var throw_dir: Vector2 = (get_global_mouse_position() - position).normalized()
	item_to_drop.interpolate_pos(position, position + throw_dir * 50)
	#if items.get_child_count() > 0: _switch_item(-1)

#code used to scroll items
func _switch_item(direction: int):
	var index: int = current_item.get_index()
	if direction == -1:
		index -= 1
		if index < 0:
			index = items.get_child_count() - 1
	elif direction == -2:
		index += 1
		if index > items.get_child_count() - 1:
			index = 0
	elif direction == 1 && max_items >= 1: index = 0
	elif direction == 2 && max_items >= 2: index = 1
	elif direction == 3 && max_items >= 3: index = 2
	elif direction == 4 && max_items >= 4: index = 3
	elif direction == 5 && max_items >= 5: index = 4
	elif direction == 6 && max_items >= 6: index = 5
	elif direction == 7 && max_items >= 7: index = 6
	elif direction == 8 && max_items >= 8: index = 7
	elif direction == 9 && max_items >= 9: index = 8
	if items.get_child_count() > 0:
		current_item.switch_from()
		current_item = items.get_child(index)
		current_item.switch_to()

func state_logic():
	var state = fsm.state
	
	#play correct animation
	if state == "move": animation_player.play("move")
	if state == "idle": animation_player.play("idle")
	if state == "hurt": animation_player.play("hurt")
	if state == "dead": animation_player.play("dead")
	
	#change state if nescessary 
	if state != "move" and velocity.length() > 10:
		fsm.set_state("move")
		damagable = true
	elif state != "idle" and velocity.length() < 10:
		fsm.set_state("idle")
		damagable = true
	if state == "hurt" and not animation_player.is_playing():
		fsm.set_state("idle")
		damagable = false
	if state == "dead":
		damagable = false

#function that handles damage and all damage related atributes
func take_damage(damage, knockback, knockback_dir, should_stun):
	if damagable:
		health -= damage
		if health > max_health:
			health = max_health
		if should_stun: fsm.set_state("hurt")
		velocity += knockback_dir * knockback

