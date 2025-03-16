extends TextureButton

func _ready() -> void:
	mouse_entered.connect(on_mouse_enter)
	
func on_mouse_enter():
	Bus.button_sound.play()
