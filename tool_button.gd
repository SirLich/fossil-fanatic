extends TextureButton

@export var game : Game
@export var tool_scene : PackedScene

func _ready() -> void:
	button_up.connect(on_pressed)
	mouse_entered.connect(on_mouse)
	
func on_pressed():
	game.change_tool(tool_scene)
	
	
func on_mouse():
	Bus.button_sound.play()
