extends Node

@export var levels_in_order : Array[PackedScene]
var current_level = -1

func get_next_level():
	current_level += 1
	return levels_in_order[current_level]
	
signal on_game_over(health, texture)
