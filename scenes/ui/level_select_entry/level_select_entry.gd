extends VBoxContainer

@export var dark_color : Color
@export var button_hover_sound : AudioStream
@export var fossil_texture : TextureRect
@export var star_container : Container


var my_level : LevelDescription

var is_hovered = false

func _ready() -> void:
	Bus.on_game_over.connect(game_over)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	modulate = dark_color
	
func game_over(health, texture):
	if Bus.get_current_level() == my_level:
		fossil_texture.texture = texture
		fossil_texture.modulate = Color.WHITE
	
func configure(level : LevelDescription):
	my_level = level
	fossil_texture.texture = level.texture
	fossil_texture.modulate = Color.BLACK

func on_mouse_entered():
	SoundManager.play_ui_sound(button_hover_sound)
	modulate = Color.WHITE
	is_hovered = true
	
func on_mouse_exited():
	modulate = dark_color
	is_hovered = false
	
func _input(event: InputEvent) -> void:
	if is_hovered:
		if event.is_action_released("use_tool"):
			Bus.play_level(my_level)
