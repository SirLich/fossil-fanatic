extends Area2D
class_name Fossil

@export var rock_particle_scene : PackedScene

@export_group("Nodes")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var max_health := 5
var health := max_health
var hovered = false

func _ready() -> void:
	await get_tree().process_frame
	set_color()
	
func set_hovered():
	animated_sprite_2d.material.set_shader_parameter("enabled", true)
	hovered = true
	
func set_unhovered():
	animated_sprite_2d.material.set_shader_parameter("enabled", false)
	hovered = false

func set_color():
	animated_sprite_2d.frame = max_health - health

func take_damage():
	if hovered:
		health -= 1
		set_color()

		if health == 0:
			if rock_particle_scene:
				var new_scene = rock_particle_scene.instantiate()
				get_parent().add_child(new_scene)
				new_scene.global_position = global_position
			queue_free()
	
