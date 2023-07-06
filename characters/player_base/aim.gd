extends Sprite2D

var aim_dir
var controller = false

func assign():
	if get_parent().assigned_control_set != 1:
		controller = true
		

func _physics_process(_delta):
	var aim_direction: Vector2 = Vector2(0, 0)
	if !controller:
		aim_direction = (get_global_mouse_position() - get_parent().global_position).normalized()
		look_at(get_parent().global_position + aim_direction)
		rotation_degrees += 45
		
	if controller:
		aim_direction.x = Input.get_action_strength("aimr" + str(get_parent().assigned_control_set)) - Input.get_action_strength("aiml" + str(get_parent().assigned_control_set))
		aim_direction.y = Input.get_action_strength("aimd" + str(get_parent().assigned_control_set)) - Input.get_action_strength("aimu" + str(get_parent().assigned_control_set))
		
		look_at(get_parent().global_position + aim_direction.normalized())
	
	aim_dir = aim_direction
	
	

func _input(_event):
	if Input.is_action_just_pressed("a" + str(get_parent().assigned_control_set)): 
		controller = true
		InputMap.action_set_deadzone("aimr" + str(get_parent().assigned_control_set), get_parent().assigned_control_deadzone)
		InputMap.action_set_deadzone("aiml" + str(get_parent().assigned_control_set), get_parent().assigned_control_deadzone)
		InputMap.action_set_deadzone("aimu" + str(get_parent().assigned_control_set), get_parent().assigned_control_deadzone)
		InputMap.action_set_deadzone("aimd" + str(get_parent().assigned_control_set), get_parent().assigned_control_deadzone)
		
		InputMap.action_set_deadzone("right" + str(get_parent().assigned_control_set), get_parent().assigned_control_deadzone)
		InputMap.action_set_deadzone("left" + str(get_parent().assigned_control_set), get_parent().assigned_control_deadzone)
		InputMap.action_set_deadzone("up" + str(get_parent().assigned_control_set), get_parent().assigned_control_deadzone)
		InputMap.action_set_deadzone("down" + str(get_parent().assigned_control_set), get_parent().assigned_control_deadzone)
		
		show()
