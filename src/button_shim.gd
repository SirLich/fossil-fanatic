extends TextureButton

func _ready() -> void:
	button_down.connect(on_mouse_enter)
	
func on_mouse_enter():
	Bus.button_sound.play()
