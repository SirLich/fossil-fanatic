extends Area2D
class_name Rock

@export var max_health := 5.0
@onready var health := max_health

@export_group("Nodes")
@export var spite : Sprite2D

var hovered = false

func set_hovered():
	spite.material.set_shader_parameter("enabled", true)
	hovered = true
	
func set_unhovered():
	spite.material.set_shader_parameter("enabled", false)
	hovered = false

	
func take_damage():
	if hovered:
		modulate = lerp(Color.BLACK, Color.WHITE, health / max_health)
		health -= 1
		
		if health == 0:
			queue_free()
	
