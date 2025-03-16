extends Node

@export var button_sound : AudioStreamPlayer

@export var destroy_effect : AudioStreamPlayer
@export var damage_effect : AudioStreamPlayer
@export var fossil_damage : AudioStreamPlayer

@export var levels_in_order : Array[LevelDescription]
var current_level = 0

func get_current_level():
	return levels_in_order[current_level]
	
func play_next_level():
	if current_level > levels_in_order.size():
		pass
	
	
	current_level += 1
	if levels_in_order.size() > current_level:
		on_level_selected.emit(levels_in_order[current_level])
	else:
		go_main_menu.emit()
	
func play_same_level():
	on_level_selected.emit(levels_in_order[current_level])

signal go_main_menu
signal on_level_selected(level)
signal on_game_over(health, texture)
