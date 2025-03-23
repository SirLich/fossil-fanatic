extends VBoxContainer

@export var dark_color : Color
@export var button_hover_sound : AudioStream
@export var fossil_texture : TextureRect
@export var star_container : Container

@export var star_scene : PackedScene
@export var empty_star : PackedScene

var my_level : LevelDescription

var is_hovered = false

var has_been_played = false

func _ready() -> void:
	Bus.on_game_over.connect(game_over)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	modulate = dark_color
	Bus.on_stars.connect(on_stars)
	
func on_stars(num_stars):
	if Bus.get_current_level() == my_level:
		for child in star_container.get_children():
			star_container.remove_child(child)
		
		for i in range(num_stars):
			add_star(star_scene)
		for i in range(3-num_stars):
			add_star(empty_star)
	
func add_star(scene_type):
	var new_scene = scene_type.instantiate()
	new_scene.custom_minimum_size = Vector2(50, 50)
	star_container.add_child(new_scene)

func game_over(health, texture):
	if Bus.get_current_level() == my_level:
		has_been_played = true
		fossil_texture.texture = texture
		fossil_texture.modulate = Color.WHITE
	
func configure(level : LevelDescription):
	my_level = level
	fossil_texture.texture = level.texture
	fossil_texture.modulate = Color.BLACK

func on_mouse_entered():
	if has_been_played:
		SoundManager.play_ui_sound(button_hover_sound)
		modulate = Color.WHITE
		is_hovered = true
	
func on_mouse_exited():
	if has_been_played:
		modulate = dark_color
		is_hovered = false
		
func _input(event: InputEvent) -> void:
	if is_hovered:
		if event.is_action_released("use_tool"):
			Bus.play_level(my_level)
