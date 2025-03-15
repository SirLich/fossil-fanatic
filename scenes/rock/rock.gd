extends Area2D
class_name Rock


@export var color = 0

@export_group("Nodes")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var max_health := 3
var health := max_health
var hovered = false

func _ready() -> void:
	set_color()
	
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
			queue_free()
	
