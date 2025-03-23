extends TextureButton

@export var url : String
@export var button_audio : AudioStream

func _ready() -> void:
	pressed.connect(on_pressed)
	mouse_entered.connect(on_mouse_entered)
	
func on_pressed():
	OS.shell_open(url)
	
func on_mouse_entered():
	SoundManager.play_ui_sound(button_audio)
	
