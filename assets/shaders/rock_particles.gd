extends Node2D

@export var particles : GPUParticles2D

func _ready() -> void:
	particles.emitting = true
	await particles.finished
	queue_free()
