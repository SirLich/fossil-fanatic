extends Node

@export var levels_in_order : Array[PackedScene]
var current_level = 0

func play_next_level():
	current_level += 1
	on_level_selected.emit(levels_in_order[current_level])
	
func play_same_level():
	on_level_selected.emit(levels_in_order[current_level])
	
signal on_level_selected(level)
signal on_game_over(health, texture)
