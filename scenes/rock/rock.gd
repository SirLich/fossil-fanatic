extends Area2D
class_name Rock

@export var max_health := 5.0
@onready var health := max_health

@export_group("Nodes")
@export var spite : Sprite2D

#func _ready():
	#area_entered.connect(on_area_entered)
	#area_exited.connect(on_area_exited)

func set_hovered():
	spite.material.set_shader_parameter("enabled", true)
	
func set_unhovered():
	spite.material.set_shader_parameter("enabled", false)
	
func take_damage():
	modulate = lerp(Color.BLACK, Color.WHITE, health / max_health)
	health -= 1
	
	if health == 0:
		queue_free()
	
