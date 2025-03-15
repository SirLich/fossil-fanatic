extends TextureButton

@export var game : Game
@export var tool_scene : PackedScene

func _ready() -> void:
	button_up.connect(on_pressed)
	
func on_pressed():
	game.change_tool(tool_scene)
	
