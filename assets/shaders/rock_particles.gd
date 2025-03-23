extends Node2D

@export var particles : Array[GPUParticles2D]

var finished_particles = 0
	
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	queue_free()
