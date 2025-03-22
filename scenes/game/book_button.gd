extends TextureButton

@export var game : Game
@export var level_select : PackedScene

func _ready() -> void:
	button_up.connect(on_pressed)
	mouse_entered.connect(on_mouse_entered)
	
func on_pressed():
	pass
	
func on_mouse_entered():
	Bus.button_sound.play()
