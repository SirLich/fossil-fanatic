extends CanvasLayer

@export var entry_scene : PackedScene
@export var container : GridContainer

func _ready() -> void:
	while container.get_child_count() > 0:
		container.get_child(0).free()
		
	for level in Bus.levels_in_order:
		var new_entry = entry_scene.instantiate()
		new_entry.configure(level)
		container.add_child(new_entry)
