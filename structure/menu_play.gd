extends Control

@onready var grid := $Grid
const LEVEL_BOX := preload("res://interface/level_box.tscn")

func _ready() -> void:
	for box: Control in grid.get_children():
		box.queue_free()
	for level_index: int in Controls.levels[0].size():
		var level_box: Control = LEVEL_BOX.instantiate()
		grid.add_child(level_box)
		level_box.init(level_index, 0)
