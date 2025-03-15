extends Node2D

@export var particles : GPUParticles2D

func _ready() -> void:
	await get_tree().process_frame
	particles.emitting = true
	await particles.finished
	queue_free()
