extends Node2D

@export var particles : Array[GPUParticles2D]

var finished_particles = 0

func _evaluate_despawn_conditions():
	finished_particles += 1
	if finished_particles == particles.size():
		queue_free()

	
func _ready() -> void:
	await get_tree().process_frame
	
	for particle in particles:
		particle.emitting = true
		particle.finished.connect(_evaluate_despawn_conditions)
