extends Node2D
class_name Game

@export var menu_appear_sound : AudioStream
@export var start_screen : CanvasLayer
@export var starting_tool : PackedScene
@export var hud : CanvasLayer

var old_tool
var start_time

@export var user_interface_slot : Node

enum HudSlot {HUD, MAIN_MENU_SCREEN, LEVEL_COMPLETE, LEVEL_SELECT, GAME_OVER}

func open_level_select_menu():
	set_ui_state(Game.HudSlot.LEVEL_SELECT, true)
	set_mouse_mode_normal()
	

	

func close_level_select_menu():
	set_ui_state(Game.HudSlot.HUD)
	change_tool(starting_tool)

func set_ui_state(slot : HudSlot, use_animation = false):
	for child in user_interface_slot.get_children():
		child.visible = false
	var child = user_interface_slot.get_child(slot)
	
	if use_animation:
		SoundManager.play_ui_sound(menu_appear_sound)
		child.offset.y = -2000
		var tween = get_tree().create_tween()
		tween.tween_property(child, "offset:y", 0, 0.4)
	
	child.visible = true
	return child
	
var my_level
func _ready() -> void:	
	Bus.on_game_over.connect(trigger_game_over)
	Bus.on_level_selected.connect(play_level)
	Bus.go_main_menu.connect(restart)
	
	set_ui_state(HudSlot.MAIN_MENU_SCREEN)

func restart():
	Bus.game_music.stop()
	Bus.menu_music.play()
	start_screen.visible = true
	hud.visible = false
	
func play_level(level : LevelDescription):
	set_ui_state(HudSlot.HUD)
	
	if my_level:
		my_level.queue_free()
	my_level = level.level_scene.instantiate()
	add_child(my_level)
	start_time = Time.get_ticks_msec()
	change_tool(starting_tool)
	
func change_tool(scene : PackedScene):
	if old_tool:
		old_tool.queue_free()
	old_tool = scene.instantiate()
	add_child(old_tool)
	
func trigger_game_over(health, texture):
	if my_level:
		my_level.queue_free()
		
	var game_time = Time.get_ticks_msec() - start_time	
	set_mouse_mode_normal()

	var game_over_ui = set_ui_state(HudSlot.LEVEL_COMPLETE, true)
	game_over_ui.set_end_game_data(game_time, health, texture)

func set_mouse_mode_normal():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if old_tool:
		old_tool.queue_free()
	
func _on_texture_button_button_up() -> void:
	start_screen.visible = false
	Bus.game_music.play()
	Bus.menu_music.stop()
	Bus.play_level_by_index(0)
