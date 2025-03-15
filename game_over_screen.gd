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
	Bus.play_same_level()
	queue_free()

func _on_next_level_button_button_up() -> void:
	Bus.play_next_level()
	queue_free()

func set_time(time):
	_time = time
		
	var total_seconds = int(time / 1000)
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	
	time_label.text = str(minutes, " Minutes ", seconds, " Seconds")
	
func set_health(health):
	_health = health
	
	var health_words = [
		" completely destroyed ",
		" very damaged ",
		" damaged ",
		" slightly damaged ",
		"nearly perfect",
		" mint "
	]
	
	var level = Bus.get_current_level()
	damage_label.text = "You discovered a " + level.name + " in " + health_words[_health] + " condition."
	
func add_star(scene_type):
	var new_scene = scene_type.instantiate()
	star_container.add_child(new_scene)

func set_stars_count(num_stars):
	for i in range(num_stars):
		add_star(star_scene)
	for i in range(3-num_stars):
		add_star(empty_star)
	
func set_stars():
	if _health == 0:
		set_stars_count(0)
	elif _health == 5:
		set_stars_count(3)
	else:
		set_stars_count(1)
		
func set_texture(texture):
	fossil.texture = texture
	

	
