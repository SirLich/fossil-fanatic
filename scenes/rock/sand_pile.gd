extends Area2D
class_name Sand

@export var destroy_audio : AudioStream

@export var sand_particle_scene : PackedScene

@export_group("Nodes")
@onready var sprite: Sprite2D = $Sprite2D

var max_health := 3
var health := max_health
var hovered = false
	
func set_hovered():
	sprite.material.set_shader_parameter("enabled", true)
	hovered = true
	
func set_unhovered():
	sprite.material.set_shader_parameter("enabled", false)
	hovered = false

func set_color():
	var modulate_values = [0.2, 0.35, 0.6, 0.8]
	sprite.modulate.a = modulate_values[health]

func take_damage():
	if hovered:
		health -= 1
		set_color()

		if health == 0:
			#Bus.destroy_effect.play()
			if sand_particle_scene:
				var new_scene = sand_particle_scene.instantiate()
				get_parent().add_child(new_scene)
				new_scene.global_position = global_position
			queue_free()
		else:
			pass
			#Bus.damage_effect.play()
