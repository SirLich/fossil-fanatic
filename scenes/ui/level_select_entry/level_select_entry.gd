extends VBoxContainer

@export var fossil_texture : TextureRect
@export var star_container : Container

var my_level : LevelDescription

func _ready() -> void:
	Bus.on_game_over.connect(game_over)
	
func game_over(health, texture):
	if Bus.current_level == my_level:
		fossil_texture.texture = texture
		fossil_texture.modulate = Color.WHITE
	
func configure(level : LevelDescription):
	my_level = level
	fossil_texture.texture = level.texture
	fossil_texture.modulate = Color.BLACK
