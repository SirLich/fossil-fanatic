extends TextureButton

@export var mouse_off_sound : AudioStream

func _ready() -> void:
	mouse_entered.connect(on_mouse_enter)
	mouse_exited.connect(on_mouse_leave)
	pressed.connect(selected)
	
func selected():
	Bus.get_game().close_level_select_menu()
	
func on_mouse_enter():
	Bus.button_sound.play()

func on_mouse_leave():
	SoundManager.play_ui_sound_with_pitch(mouse_off_sound, 0.5)
