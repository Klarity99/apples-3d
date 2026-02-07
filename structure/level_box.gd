extends Control

@onready var title_lbl := $Title
var level_index: int
var track_index: int

func init(arg_level_index: int, arg_track_index: int) -> void:
	level_index = arg_level_index
	track_index = arg_track_index
	title_lbl.text = Controls.levels[arg_track_index][arg_level_index]
	
func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	Controls.open_level(level_index, track_index)
