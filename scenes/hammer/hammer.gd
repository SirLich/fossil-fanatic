extends Area2D
class_name Hammer

@export var size = 20

@export_group("Nodes")
@export var anim_player : AnimationPlayer

var can_hit = true

var circle_points = []
var old_colliders = []
var colliders = []

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	scale = Vector2(size, size)
	
func _process(delta):
	global_position = get_global_mouse_position()
	queue_redraw()

func _draw() -> void:
	draw_set_transform_matrix(global_transform.affine_inverse())

	for point in circle_points:
		draw_circle(point, 2, Color(1, 0, 0), true)
		
func _physics_process(delta: float) -> void:
	detect_rocks()
	
func _input(event: InputEvent) -> void:
	if can_hit:
		if event.is_action_released("use_tool"):
			can_hit = false
			anim_player.play("hit")
			await anim_player.animation_finished
			can_hit = true

func apply_damage():
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
		)
		
		colliders.append(intersections[0].collider)

func get_chunks(c, h, k, r, step):
	var center = c - Vector2(h, k)
	var chunks = []

	var min_x = h - r
	var max_x = h + r
	var min_y = k - r
	var max_y = k + r
	
	for x in range(min_x, max_x + 1, step):
		for y in range(min_y, max_y + 1, step):
			if (x - h) * (x - h) + (y - k) * (y - k) <= r * r:
				chunks.append(center + Vector2(x, y))
	
	return chunks

	
func detect_rocks():
	
	var center = get_viewport().get_mouse_position()

	var scaled_size = size * 5
	circle_points = get_chunks(get_viewport().get_mouse_position(), scaled_size, scaled_size, scaled_size, 20)
	
	for point in circle_points:
		gather_colliders(point)

	for collider in old_colliders:
		if collider not in colliders:
			if collider:
				collider.set_unhovered()
			
	for collider in colliders:
		if collider not in old_colliders:
			if collider:
				collider.set_hovered()
	
	old_colliders.clear()
	for collider in colliders:
		old_colliders.append(collider)
	colliders.clear()
