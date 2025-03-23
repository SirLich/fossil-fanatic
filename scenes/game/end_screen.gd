extends CanvasLayer

@export var continue_button : TextureButton

func _ready() -> void:
	continue_button.pressed.connect(on_pressed)
	
func on_pressed():
	Bus.get_game().set_ui_state(Game.HudSlot.MAIN_MENU_SCREEN)
