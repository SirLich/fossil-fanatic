extends Area2D
class_name Fossil

@export var rock_particle_scene : PackedScene

@export_group("Nodes")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var max_health := 5
var health := max_health
var hovered = false

var is_ready = false

func get_current_texture(frame):
	var spriteFrames: SpriteFrames = animated_sprite_2d.get_sprite_frames()
	return spriteFrames.get_frame_texture("default", frame)
	
func _process(delta: float) -> void:
	if is_ready:
		if get_overlapping_areas().size() == 0:
			Bus.on_game_over.emit(health, get_current_texture( max_health - health))
			self.queue_free()
		
func _ready() -> void:
	set_color()
	
	await get_tree().create_timer(0.1).timeout
	is_ready = true
	
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
		
		Bus.fossil_damage.play()
		if health == 0:
			if rock_particle_scene:
				var new_scene = rock_particle_scene.instantiate()
				get_parent().add_child(new_scene)
				new_scene.global_position = global_position
				
			Bus.on_game_over.emit(health, get_current_texture(4))
			queue_free()
	
