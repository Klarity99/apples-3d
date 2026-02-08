extends Node

var gems := 0
var level_gems := 0
var level_index := 0
var track_index := 0

var levels := []
var loc := Vector2i.ZERO

signal gems_changed

func _ready() -> void:
	levels.push_front(Calc.get_files_in_folder("res://levels", false))
	if Debug.start_level:
		open_level()

func set_loc(vec: Vector2i) -> void:
	if loc == vec: return
	loc = vec
	Nodes.cameras.set_loc(loc)

func collect_gem():
	gems += 1
	gems_changed.emit()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		restart_level()
	for i in 10:
		if Input.is_action_just_pressed("num_" + str(i)):
			open_level(i - 1)
		
func restart_level():
	open_level(level_index, track_index)
	
func open_level(arg_level_index := level_index, arg_track_index := track_index) -> void:
	if arg_track_index >= levels.size(): return
	if arg_level_index >= levels[arg_track_index].size(): return
	if Nodes.menu:
		Nodes.menu.queue_free()
	level_index = arg_level_index
	track_index = arg_track_index
	var level_id = levels[track_index][level_index]
	var level: Node3D = load("res://levels/%s.tscn" % level_id).instantiate()
	if Nodes.level:
		Nodes.level.queue_free()
	Nodes.level = level
	Nodes.init_level()
	if Nodes.interface:
		Nodes.interface.queue_free()
	var interface: Control = load("res://interface/interface.tscn").instantiate()
	Nodes.interface = interface
	await get_tree().process_frame
	gems = 0
	level_gems = 0
	Nodes.game.add_child(level)
	Nodes.game.add_child(interface)
	gems_changed.emit()
	
	
	
