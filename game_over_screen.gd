extends CanvasLayer
class_name GameOverScreen

@export var time_label : Label
@export var damage_label : Label
@export var time_need_label : Label
@export var star_container : Container
@export var star_scene : PackedScene
@export var empty_star : PackedScene
@export var fossil : TextureRect

var _health 
var _time
var _texture

func _ready() -> void:	
	offset.y = -2000
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset:y", 0, 0.4)

func _on_replay_button_button_up() -> void:
	Bus.play_same_level()
	queue_free()

func _on_next_level_button_button_up() -> void:
	Bus.play_next_level()
	queue_free()

func get_time_as_string(in_time):
	var total_seconds = int(in_time / 1000)
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	return str(minutes, " Minutes ", seconds, " Seconds")

func set_end_game_data(time, health, texture):
	_health = health
	_texture = texture
	_time = time
	
	time_label.text = get_time_as_string(time)
	fossil.texture = _texture

	
	set_health()
	set_stars()

func set_health():
	var health_words = [
		" completely destroyed ",
		" very damaged ",
		" damaged ",
		" slightly damaged ",
		" nearly perfect",
		" perfect "
	]
	
	var level = Bus.get_current_level()
	damage_label.text = "You discovered a " + level.name + " in " + health_words[_health] + " condition."
	
	var required_time_msecs = level.best_time_seconds * 1000
	if _time > required_time_msecs:
		time_need_label.text = "Time to beat: " + get_time_as_string(required_time_msecs)
	else:
		time_need_label.text = "That was blazing fast!"
	
	
func add_star(scene_type):
	var new_scene = scene_type.instantiate()
	star_container.add_child(new_scene)

func set_stars_count(num_stars):
	for child in star_container.get_children():
		star_container.remove_child(child)
	
	for i in range(num_stars):
		add_star(star_scene)
	for i in range(3-num_stars):
		add_star(empty_star)

func was_time_fast():
	var level = Bus.get_current_level()
	return _time <= level.best_time_seconds * 1000
	
func set_stars():
	var level = Bus.get_current_level()


	if _health == 0:
		set_stars_count(0)
	elif _health == 5 and was_time_fast():
		set_stars_count(3)
	elif _health >= 3:
		set_stars_count(2)
	else:
		set_stars_count(1)
		
	

	
