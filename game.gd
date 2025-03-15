extends Node2D
class_name Game

@export var starting_tool : PackedScene
@export var game_over_scene : PackedScene

var old_tool

func _ready() -> void:
	change_tool(starting_tool)
	
func change_tool(scene : PackedScene):
	if old_tool:
		old_tool.queue_free()
	old_tool = scene.instantiate()
	add_child(old_tool)
	
func trigger_game_over():
	var game_over = game_over_scene.instantiate()
