extends Area2D
class_name Pebbles

@export var use_dust = true
@export var use_pebbles = true

@export var dust_color = 0
@export var pebble_color = 0

@export var max_health := 4

@export_group("Nodes")
@export var dust_sprite: AnimatedSprite2D 
@export var pebble_sprite : AnimatedSprite2D 

var health
var hovered = false

func _ready() -> void:
	health = max_health
	await get_tree().process_frame
	set_color()
	dust_sprite.material.set_shader_parameter("modulate", get_parent().modulate)
	pebble_sprite.material.set_shader_parameter("modulate", get_parent().modulate)

	dust_sprite.visible = use_dust
	pebble_sprite.visible = use_pebbles

func set_hovered():
	dust_sprite.material.set_shader_parameter("enabled", true)
	pebble_sprite.material.set_shader_parameter("enabled", true)
	hovered = true
	
func set_unhovered():
	dust_sprite.material.set_shader_parameter("enabled", false)
	pebble_sprite.material.set_shader_parameter("enabled", false)
	hovered = false

func set_color():
	dust_sprite.frame = max_health - health + (4 * dust_color)
	pebble_sprite.frame = max_health - health + (4 * pebble_color)

func take_damage():
	if hovered:
		health -= 1
		set_color()

		if health == 0:
			queue_free()
		else:
			pass
