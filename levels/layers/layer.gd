extends Node2D

@export var color = 0
@export var use_color = false

func _ready() -> void:
	if use_color:
		for child in get_children():
			child.color = color
