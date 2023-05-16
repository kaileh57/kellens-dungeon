extends CharacterBase
class_name EnemyBase


#define the nodes used for pathfinding
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var navigation: NavigationRegion2D = get_tree().current_scene.find_node("NavigationRegion2D")

var target: CharacterBody2D
@onready var hitbox = $HurtBox

var started: bool = false



#godot built in pathfinding system
func chase():
	var direction: Vector2 
	if started:
		direction = global_position.direction_to(agent.get_next_location())
		velocity = direction * max_speed
	hitbox.knockback_direction = direction
	#velocity = move_and_slide()

#every time this timer runs out the enemy recalculates a path
func _on_PathTimer_timeout():
	var closest_player
	var closest_dist = INF
	for i in $"/root/GlobalSettings".player_list:
		var dist = abs(self.position.distance_to(i.position))
		if dist < closest_dist:
			closest_player = i
			closest_dist = dist
		
	if !started: started = true
	if is_instance_valid(target): agent.set_target_location(target.global_position)
