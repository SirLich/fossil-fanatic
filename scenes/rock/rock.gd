extends Area2D
class_name Rock


@export var destroy_audio : AudioStream

@export var color = 0
@export var rock_particle_scene : PackedScene

@export_group("Nodes")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var max_health := 3
var health := max_health
var hovered = false

func _ready() -> void:
	await get_tree().process_frame
	set_color()
	animated_sprite_2d.material.set_shader_parameter("modulate", get_parent().modulate)

	
func set_hovered():
	animated_sprite_2d.material.set_shader_parameter("enabled", true)
	hovered = true
	
func set_unhovered():
	animated_sprite_2d.material.set_shader_parameter("enabled", false)
	hovered = false

func set_color():
	animated_sprite_2d.frame = max_health - health + (3 * color)

func take_damage():
	if hovered:
		health -= 1
		set_color()

		if health == 0:
			Bus.destroy_effect.play()
			if rock_particle_scene:
				var new_scene = rock_particle_scene.instantiate()
				get_parent().add_child(new_scene)
				new_scene.global_position = global_position
			queue_free()
		else:
			Bus.damage_effect.play()
