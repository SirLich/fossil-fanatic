extends Area2D
class_name Hammer

@export var size = 20

func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	scale = Vector2(size, size)
	
func _process(delta):
	global_position = get_global_mouse_position()
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("use_tool"):
		for object_area in get_overlapping_areas():
			object_area.take_damage()
