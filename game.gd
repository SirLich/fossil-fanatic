extends Node2D
class_name Game

@export var starting_tool : PackedScene
@export var game_over_scene : PackedScene
@export var hud : CanvasLayer

var game_over_ui

var old_tool
var start_time

func _ready() -> void:
	Bus.on_game_over.connect(trigger_game_over)
	Bus.on_level_selected.connect(play_level)
	Bus.play_same_level()
	
func play_level(level : LevelDescription):
	hud.visible = true
	var new_level = level.level_scene.instantiate()
	add_child(new_level)
	start_time = Time.get_ticks_msec()
	change_tool(starting_tool)
	
func change_tool(scene : PackedScene):
	if old_tool:
		old_tool.queue_free()
	old_tool = scene.instantiate()
	add_child(old_tool)
	
func trigger_game_over(health, texture):
	var game_time = Time.get_ticks_msec() - start_time
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	old_tool.queue_free()
	hud.visible = false
	game_over_ui = game_over_scene.instantiate()
	game_over_ui.set_time(game_time)
	game_over_ui.set_health(health)
	game_over_ui.set_stars()
	game_over_ui.set_texture(texture)
	add_child(game_over_ui)
