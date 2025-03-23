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
var current_level : LevelDescription

func get_game() -> Game:
	for child in get_parent().get_children():
		if child is Game:
			return child
	return null
	
func on_rock_hit(location):
	damage_effect.play()

func get_current_level():
	return current_level

func get_level_index():
	return levels_in_order.find(current_level)
	
func has_next_level():
	return get_level_index() + 1 < levels_in_order.size()
	
func play_next_level():
	if has_next_level():
		play_level_by_index(get_level_index() + 1)
	else:
		get_game().set_ui_state(Game.HudSlot.GAME_OVER)

func play_level_by_index(index):
	play_level(levels_in_order[index])
	
func play_same_level():
	play_level(current_level)

func play_level(level : LevelDescription):
	current_level = level
	on_level_selected.emit(current_level)
	
signal go_main_menu
signal on_level_selected(level)
signal on_game_over(health, texture)
signal on_stars(num_stars)
