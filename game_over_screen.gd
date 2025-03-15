extends CanvasLayer
class_name GameOverScreen

@export var time_label : Label
@export var damage_label : Label
@export var star_container : Container
@export var star_scene : PackedScene
@export var empty_star : PackedScene
@export var fossil : TextureRect

var _health 
var _time

func _ready() -> void:	
	offset.y = -2000
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset:y", 0, 0.4)
	
func _on_replay_button_button_up() -> void:
	var tree := get_tree()
	var scene_path := tree.current_scene.scene_file_path
	await get_tree().create_timer(0.1).timeout
	tree.call_deferred("unload_current_scene")
	tree.call_deferred("change_scene_to_file", scene_path)

func _on_next_level_button_button_up() -> void:
	pass # Replace with function body.

func set_time(time):
	_time = time
	time_label.text = str(time)
	
func set_health(health):
	_health = health
	damage_label.text = str(health)

func add_star(scene_type):
	var new_scene = scene_type.instantiate()
	star_container.add_child(new_scene)

func set_stars_count(num_stars):
	for i in range(num_stars):
		add_star(star_scene)
	for i in range(3-num_stars):
		add_star(empty_star)
	
func set_stars():
	if _health == 5:
		set_stars_count(3)
	else:
		set_stars_count(1)
		
func set_texture(texture):
	fossil.texture = texture
	

	
