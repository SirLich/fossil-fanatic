extends Node

@export_group("Particles")
@export var rock_hit_particle : PackedScene

@export_group("Sounds")
@export var menu_music :AudioStreamPlayer
@export var game_music :AudioStreamPlayer
@export var button_sound : AudioStreamPlayer
@export var destroy_effect : AudioStreamPlayer
@export var damage_effect : AudioStreamPlayer
@export var fossil_damage : AudioStreamPlayer

@export var levels_in_order : Array[LevelDescription]
var current_level_num = 0
var current_level : LevelDescription

func get_game() -> Game:
	for child in get_parent().get_children():
		if child is Game:
			return child
	return null
	
func on_rock_hit(location):
	damage_effect.play()

func get_current_level():
	return levels_in_order[current_level_num]
	
func play_next_level():
	if current_level_num > levels_in_order.size():
		pass
	
	
	current_level_num += 1
	if levels_in_order.size() > current_level_num:
		play_level(levels_in_order[current_level_num])
	else:
		current_level_num = 0
		go_main_menu.emit()
	
func play_same_level():
	play_level(levels_in_order[current_level_num])

func play_level(level : LevelDescription):
	current_level = level
	on_level_selected.emit(current_level)
	
signal go_main_menu
signal on_level_selected(level)
signal on_game_over(health, texture)
