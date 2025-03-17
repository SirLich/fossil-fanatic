extends Node2D
class_name Game

@export var start_screen : CanvasLayer
@export var starting_tool : PackedScene
@export var game_over_scene : PackedScene
@export var hud : CanvasLayer

var game_over_ui

var old_tool
var start_time

var my_level
func _ready() -> void:
	hud.visible = false
	Bus.on_game_over.connect(trigger_game_over)
	Bus.on_level_selected.connect(play_level)
	Bus.go_main_menu.connect(restart)

func restart():
	Bus.game_music.stop()
	Bus.menu_music.play()
	start_screen.visible = true
	hud.visible = false
	
func play_level(level : LevelDescription):
	hud.visible = true
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
	var game_time = Time.get_ticks_msec() - start_time
	
	my_level.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	old_tool.queue_free()
	hud.visible = false
	game_over_ui = game_over_scene.instantiate()
	
	game_over_ui.set_end_game_data(game_time, health, texture)
	#game_over_ui.set_time(game_time)
	#game_over_ui.set_health(health)
	#game_over_ui.set_stars()
	#game_over_ui.set_texture(texture)
	add_child(game_over_ui)


func _on_texture_button_pressed() -> void:
	start_screen.visible = false
	Bus.game_music.play()
	Bus.menu_music.stop()
	Bus.play_same_level()
