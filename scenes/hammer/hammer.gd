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

func gather_colliders(pos):
	var world_2d = get_viewport().find_world_2d()
	var direct_space = world_2d.direct_space_state
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collision_mask = pow(2, 1-1)
	
	var intersections = direct_space.intersect_point(query)
	if intersections:
		intersections.sort_custom(func(a, b):
			var obj_a = a.collider
			var obj_b = b.collider
			
			var obj_a_order = obj_a.get_parent().get_index() * 1000 + obj_a.get_index()
			var obj_b_order = obj_b.get_parent().get_index() * 1000 + obj_b.get_index()

			return obj_a_order > obj_b_order
			#return obj_a.get_parent().get_z_index() > obj_b.get_parent().get_z_index()
		)
		
		colliders.append(intersections[0].collider)

	
var old_colliders = []
var colliders = []

func detect_rocks():
	
	gather_colliders(get_viewport().get_mouse_position())
	#gather_colliders(get_viewport().get_mouse_position() - Vector2(100, 0))

	for collider in old_colliders:
		if collider not in colliders:
			collider.set_unhovered()
			
	for collider in colliders:
		if collider not in old_colliders:
			collider.set_hovered()
	
	old_colliders.clear()
	for collider in colliders:
		old_colliders.append(collider)
	colliders.clear()
