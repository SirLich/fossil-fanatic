@tool
extends Control

func _process(delta: float) -> void:
	await get_tree().process_frame
	custom_minimum_size = get_child(0).size * scale
