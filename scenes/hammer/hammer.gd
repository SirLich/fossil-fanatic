extends Area2D
class_name Hammer

@export var size = 20

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	scale = Vector2(size, size)
	
func _process(delta):
	global_position = get_global_mouse_position()
	
func _physics_process(delta: float) -> void:
	detect_rocks()
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("use_tool"):
		for object_area in get_overlapping_areas():
			object_area.take_damage()

var old_colliders = []
func detect_rocks():
	var world_2d = get_viewport().find_world_2d()
	var direct_space = world_2d.direct_space_state

	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_viewport().get_mouse_position()
	query.collide_with_areas = true
	query.collision_mask = pow(2, 1-1)

	var colliders = []
	var intersections = direct_space.intersect_point(query)
	if intersections:
		for intersection in intersections:
			var collider = intersection.collider
			colliders.append(collider)
	
	for collider in old_colliders:
		if collider not in colliders:
			collider.set_unhovered()
			
	for collider in colliders:
		if collider not in old_colliders:
			collider.set_hovered()
	
	old_colliders.clear()
	for collider in colliders:
		old_colliders.append(collider)

		
	
	
	
	
		#intersections.sort_custom(func(a, b):
			#var obj_a = a.collider
			#var obj_b = b.collider
			#return obj_a.global_position.y > obj_b.global_position.y
		#)
