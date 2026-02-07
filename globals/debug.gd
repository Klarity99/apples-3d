extends Node

var double_speed := false
var start_level := true

func _ready() -> void:
	await get_tree().process_frame
	if double_speed:
		Nodes.player.speed *= 2.0